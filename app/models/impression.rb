class Impression < ActiveRecord::Base
  belongs_to :impressionable, polymorphic: true, counter_cache: true
  # has_many :referrals, dependent: :destroy
  belongs_to :user

  scope :last_week, -> {
    where("date_trunc('week', created_at)
    BETWEEN date_trunc('week', now()) - INTERVAL '1 WEEK'
    AND date_trunc('week', now())")
  }

  def self.impress(object, request, user)
    user_id = user.id if user
    impression = Impression.where(impressionable_type: object.try(:class).to_s, impressionable_id: object.try(:id), ip: request.remote_ip, user_id: user_id).first_or_initialize
    if impression.new_record?
      if request.referrer
        protocol,domain,path = request.referrer.scan(/(?:(.*):\/\/)?(?:w+\.)?([^\/]*)(.*)/).flatten
        if domain != request.host_with_port
          path = request.referrer if domain.nil? && path.nil?
          # impression.referrals.new(referrable: object,
          #   domain: domain,
          #   path: path.truncate(250)
          # )
        end
      end
      impression.hits = 1
      impression.save!
    else
      impression.update_column :hits, impression.hits + 1
    end
  end

  def self.recent
    items = last_week
    items = items.select('date(created_at) as created_at, sum(hits) as total_hits').group('date(created_at)')
    impressions = {}
    items.map { |e| impressions[e.created_at.to_date] = e.total_hits }
    (1.week.ago.to_date..Date.today).map do |d|
      { date: d.strftime('%A'), count: impressions[d].present? ? impressions[d] : 0 }
    end
  end

end