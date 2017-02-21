class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.where(token: cookies[:auth_token]).take if cookies[:auth_token]
  end
  helper_method :current_user

  def current_area
    @current_area ||= current_user.subscriptions.where(area_id: params[:area_id]).take
  end
  helper_method :current_user

  def global
    @global = Area.new
    @global.theme = Theme.find_by_name('global') || Theme.new
  end
  helper_method :current_user

  # def authorize!
  #   if current_user.nil?
  #     # session[:redirected_from] = request.original_url
  #     redirect_to signin_path, error: 'You need to sign in'
  #   end
  # end
  # helper_method :authorize!

  def authorize_admin!
    unless current_user && current_user.admin?
      # session[:redirected_from] = request.original_url
      redirect_to signin_path, error: 'You need to sign in'
    end
  end
  helper_method :authorize_admin!

  def sign_in(auth_token)
    cookies[:auth_token] = auth_token
    @current_user = User.where(token: cookies[:auth_token]).take unless auth_token.nil?
  end
  helper_method :sign_in

  def sign_out
    # current_user.update_columns(token: nil) if current_user
    cookies.delete :auth_token
    @current_user = nil
  end
  helper_method :sign_out

  def nav_items
    @nav_items ||= Area.where(navigation: true).order(position: :asc)
  end
  helper_method :nav_items

  def footer_items
    @footer_items ||= Area.where(footer: true).order(position: :asc)
  end
  helper_method :footer_items

  def friendly_area_url(area)
    root_url + area.label
  end
  helper_method :friendly_area_url
  
end
