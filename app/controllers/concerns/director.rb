module Director
  extend ActiveSupport::Concern
  include UrlHelpers

  def self.to(request, user)
    if user.nil?
      UrlHelpers.signin_path
    elsif user.invalid?
      UrlHelpers.signin_path
    elsif user.admin?
      UrlHelpers.admin_path
    else
      UrlHelpers.profile_path
    end
  end

end