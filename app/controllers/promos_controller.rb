class PromosController < ApplicationController
  before_action :set_promo

  def show
    if @promo
      @promo.add_hit unless cookies.encrypted[:promo].present?
      cookies.permanent.encrypted[:promo] = @promo.name

      # get coupon from Stripe
      # store discount value in cookie for arithmetic to display preview price
      @coupon = Stripe::Coupon.retrieve(@promo.stripe_coupon)
      unless @coupon.percent_off.nil?
        cookies.permanent[:promo_percent_off] = @coupon.percent_off
      end
      
      @url = friendly_area_url @promo.course
      flash[:notice] = @promo.message unless @promo.message.blank?
    end
    @url ||= root_url
    redirect_to @url
  end

  private

  def set_promo
    @promo = Promo.where(enabled: true).find_by_name params[:promo]
  end

end
