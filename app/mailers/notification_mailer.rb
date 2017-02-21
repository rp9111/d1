class NotificationMailer < ActionMailer::Base

  default from: ENV["MAILER_FROM"], reply_to: ENV["MAILER_REPLY"]

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.confirm.subject
  #
  def confirm_account(user)
    @name = user.first_name
    @confirm_url = confirm_url(user.token)

    mail to: user.email, subject: 'Account confirmation'
  end

  def user_reset(user)
    @name = user.first_name
    @confirm_url = confirm_url(user.token)

    mail to: user.email, subject: 'Password reset'
  end
end
