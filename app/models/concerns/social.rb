module Social
  extend ActiveSupport::Concern

  def send_to_twitter!(tweet)
    return unless twitter_posts?
    # :nocov:
    oauthid = oauthids.where(provider: 'twitter').take
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_ID']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = oauthid.token
      config.access_token_secret = oauthid.secret
    end

    client.update(tweet)
    # :nocov:
  end

  def send_to_facebook!(wall_post)
    return unless facebook_posts?
    # :nocov:
    oauthid = oauthids.where(provider: 'facebook').take
    graph = Koala::Facebook::API.new(oauthid.token)

    graph.put_connections('me', 'feed', message: wall_post)
    # :nocov:
  end
end
