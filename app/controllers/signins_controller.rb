class SigninsController < ApplicationController
  layout 'profile'

  def new
  end

  def create
    if params[:message] == 'invalid_credentials'
      flash[:error] = 'Email and password did not match.'
      redirect_to :back
    else
      user = assign_user
      flash[:info] = 'You are signed in'
      # redirect_to Director.to(request, user)
      redirect_to root_url
    end
  end
  
  def edit
  end

  def update
    @user = User.where('email = ? OR user_name = ?', params[:email].to_s, params[:email].to_s).take
    if @user
      @user.reset!
      NotificationMailer.user_reset(@user).deliver_now!
    end
    flash[:info] = 'An email with reset instructions has been sent to your inbox.'
    redirect_to signin_url
  end

  def confirm
    @user = User.where(reset_token: params[:token].to_s).where('reset_at > ?', 15.minutes.ago).take
    if @user
      @user.confirm!
      sign_in @user.token
      redirect_to edit_user_path
    else
      redirect_to signin_path
    end
  end

  # :nocov:
  def remove
    oauthid = current_user.oauthids.where(provider: params[:provider].to_s)
    oauthid.destroy_all if oauthid.any?
    redirect_to profile_path
  end
  # :nocov:

  def destroy
    sign_out
    redirect_to signin_path
  end

  private

  def assign_user
    user = current_user
    if user.nil?
      user = User.find_by_email request.env['omniauth.auth']['info']['email']
    end
    user = Oauthid.from_auth(request.env['omniauth.auth'], user)
    if user
      user.regenerate_token if user.token.nil?
      user.update_column(:user_name, params['user_name']) if user.user_name.blank?
      cookies[:auth_token] = { value: user.token, expires: 1.month.from_now }
    end
    user
  end

  def provider
    if request.env['omniauth.auth'].present?
      request.env['omniauth.auth']['provider']
    else
      nil
    end
  end

end
