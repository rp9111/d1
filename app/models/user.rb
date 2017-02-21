class User < OmniAuth::Identity::Models::ActiveRecord
  include Stripe::Callbacks
  belongs_to  :group
  has_many    :comments, dependent: :destroy
  has_many    :uploads # dependents destroyed by the page
  has_many    :subscription, dependent: :destroy

  include OAuthFetch
  include Social
  include Tokens

  mount_uploader :avatar, AvatarUploader

  liquid_methods :admin, :name, :email, :account_current, :stripe_id, :plan_id, :active_until, :sku_ids

  before_save :fix
  # validates :user_name, uniqueness: true, length: { in: 3..32 }
  validates :password, length: { in: 8..72 }, allow_nil: true
  validates :email, uniqueness: true, allow_nil: true, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$\z/i }
  
  attr_accessor :stripe_card_token, :skus

  after_customer_updated! do |customer, event|
    logger.debug "Stripe event: customer.id #{customer.id}: deliquent: #{customer.delinquent}"
    user = User.find_by_stripe_token(customer.id)
    if customer.delinquent
      user.account_current = false
      user.save!
    end
  end

  def name
    ([first_name, last_name].join ' ').squeeze.strip
  end

  def name=(full)
    full = full.squeeze.strip.split
    self.first_name = full[0]
    self.last_name = full[1..-1].join(' ')
  end
  
  def has_subscription_for?(area)
    admin? || subscriptions.collect(&:area_id).include?(area.id)
  end
  
  def subscription_for(area_id)
    subscriptions.find_or_initialize_by(area_id: area_id)
  end
  
  def skus
    sku_ids.to_s.split
  end

  def skus=(ids)
    self.sku_ids = ids.to_a.join(' ')
  end
  
  def add_sku(other_sku)
    self.skus = skus + [other_sku]
  end

  def has_sku(other_sku)
    skus.to_a.include? other_sku
  end

  def has_matching_sku(other_skus)
    (skus.to_a & other_skus.to_a).any?
  end
  
  def add_sku(sku)
    self.sku_ids = [sku_ids, sku].join(' ')
  end
  
  def has_access_to?(area)
    return true if admin
    available = Sku.where('plan_id IN (?) and plan_id IN (?)', skus, area.skus)
    available.each do |s|
      if skus.include? s.plan_id
        return true if (s.interval == 'lifetime' || account_current)
      end
    end
    false
  end
  
  def cancel_subscription
    begin
      customer = Stripe::Customer.retrieve(stripe_id)
      sub_id = customer.subscriptions.data[0].id
      plan_id = customer.subscriptions.data[0].plan.id
      self.skus = skus - [plan_id]
      subscription = Stripe::Subscription.retrieve(sub_id)
      subscription.delete(at_period_end: true)
    rescue
      return false
    end
    return save
  end

  protected

  def fix
    fix_user_name
    fix_email
  end

  def fix_user_name
    self.user_name ||= [first_name, last_name].join(' ')
    self.user_name.strip!
    self.user_name = user_name.parameterize(separator: '_')
  end

  def fix_email
    return if email.blank?
    email.strip!
    email.downcase!
  end
  
end
