class SubscriptionsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :global
  # before_action :find_subscription, only: [:new, :update]
  layout 'themer'

  def index
  end

  def new
    @user = current_user || User.new
    if @user.has_sku(params[:plan_id])
      flash[:notice] = 'You already have that!'
      redirect_to root_url
    else
      @plan = Sku.find_by_plan_id(params[:plan_id])
      @value = @plan.amount
      unless(@plan.interval == 'lifetime')
        promo = Promo.where(enabled: true).find_by_name(cookies.encrypted[:promo])
        unless(promo.nil?)
          coupon = Stripe::Coupon.retrieve(promo.stripe_coupon)
          unless(coupon.nil?)
            unless(coupon.percent_off.nil?)
              @value = (@value - (@value * (coupon.percent_off.to_f / 100)))
            end
          end
        end
      end
      @value = @value / 100

      render 'new'
    end
  end

  def create
    success = true
    @user = current_user
    @user ||= User.find_or_initialize_by(email: params[:user][:email]) if params[:user].present?
    @user ||= User.new
    sku = Sku.find_by_plan_id(subscription_params[:plan_id])
    @user.attributes = subscription_params
    promo = Promo.where(enabled: true).find_by_name(cookies.encrypted[:promo]) || Promo.new
    @user.promo = promo.name if promo

    # validate user before trying Stripe charge
    if (!@user.valid? || @user.errors.count > 0)
      success = false
      @plan = Sku.find_by_plan_id(@user.plan_id || params[:plan_id])
      render 'new'
    else # user is valid, proceed with Stripe charge
      if (@user.has_sku(sku.plan_id))
        success = false
        cookies.delete :promo
        flash[:notice] = "You already have the #{sku.name}. There's no need to pay twice!"
        redirect_to root_url and return
      end

      stripe_token = nil

      # one-time purchase
      if sku.interval == 'lifetime' # non-subscription
        begin
          charge = Stripe::Charge.create(
            amount: sku.amount, # Amount in cents
            currency: "usd",
            source: @user.stripe_token,
            receipt_email: @user.email,
            metadata: {email: @user.email, sku: sku.plan_id, promo: promo.name, coupon: promo.stripe_coupon},
            statement_descriptor: "#{sku.plan_id}",
            description: sku.name
          )
          # @user.attributes = {stripe_token: nil, active_until: 100.years.from_now, account_current: true}
          @user.attributes = {stripe_token: nil}
          @user.add_sku sku.plan_id
          flash[:notice] = 'Thank you for your payment'
        rescue Exception => e
          @user.attributes = { stripe_token: nil }
          logger.error "ERROR PROCESSING CARD: #{e.to_s}"
          flash[:notice] = 'The card has been declined'
          success = false
        end
      else # subscription
        @user.skus.each do |s|
          challenge = Sku.find_by_plan_id(s)
          if challenge.interval != 'lifetime'
            success = false
            cookies.delete :promo
            flash[:notice] = "You already have the #{challenge.name}. You don't need the #{sku.name}."
            redirect_to root_url and return
          end
        end
        begin
          if promo
            customer = Stripe::Customer.create(
              source: @user.stripe_token,
              plan: @user.plan_id,
              email: @user.email,
              metadata: {email: @user.email, sku: sku.plan_id, promo: promo.name, coupon: promo.stripe_coupon},
              coupon: promo.stripe_coupon
            )
            msg = customer.discount.present? ? "Your discount of was applied. " : ""
            @user.add_sku sku.plan_id
          else
            customer = Stripe::Customer.create(
              source: @user.stripe_token,
              plan: @user.plan_id,
              email: @user.email
            )
            stripe_token = customer.id
            @user.add_sku sku.plan_id
          end
          @user.attributes = { stripe_id: customer.id, stripe_token: stripe_token, active_until: 32.days.from_now, account_current: true }
          flash[:notice] = "#{msg}Thank you for your subscription"
        rescue Exception => e
          if e.message.include?('NO_COUPON')
            cookies.delete :promo
            retry
          else
            @user.attributes = { stripe_token: nil }
            flash[:notice] = e.message
            success = false
          end
        end
      end

      success = @user.save if success
      if success
        promo.add_conversion if promo
        cookies.delete :promo

        # log them in
        @user.regenerate_token if @user.token.nil?
        cookies[:auth_token] = { value: @user.token, expires: 1.month.from_now }
        redirect_to ENV['THANK_YOU_URL'].to_s
      else
        @plan = Sku.find_by_plan_id(@user.plan_id || params[:plan_id])
        render 'new'
      end
    end
  end

  private

  def find_subscription
    @subscription ||= Subscription.find_or_initialize_by(user: current_user)
  end

  def subscription_params
    params.require(:user).permit(:stripe_card_token, :email, :password, :plan_id, :stripe_token, :name)
  end

end
