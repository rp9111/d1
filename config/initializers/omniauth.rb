Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, model: User, fields: [:user_name, :email], on_failed_registration: lambda { |env|
    UsersController.action(:new).call(env)
  }
  provider :facebook, ENV['FACEBOOK_API_ID'], ENV['FACEBOOK_API_SECRET'], scope: 'email,publish_actions'
  provider :google_oauth2, ENV['GOOGLE_API_ID'], ENV['GOOGLE_API_SECRET']
  provider :instagram, ENV['INSTAGRAM_API_ID'], ENV['INSTAGRAM_API_SECRET']
  provider :twitch, ENV['TWITCH_API_ID'], ENV['TWITCH_API_SECRET']
  provider :twitter, ENV['TWITTER_API_ID'], ENV['TWITTER_API_SECRET']
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end
