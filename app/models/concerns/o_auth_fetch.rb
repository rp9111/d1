module OAuthFetch
  extend ActiveSupport::Concern

  included do
    has_many :oauthids, dependent: :destroy
    store_accessor :preferences, :send_to_twitter, :send_to_facebook
  end

  def fetch_details(auth)
    send("fetch_details_from_#{auth.provider.downcase}", auth)
    (self.remote_avatar_url = auth.info.image) unless avatar?
    self.email ||= auth.info.email unless auth.info.email.blank?
  end

  def fetch_details_from_twitter(auth)
    names = auth.info.name.split
    self.first_name ||= names[0..-2].join(' ')
    self.last_name ||= names[-1]
    self.user_name ||= auth.info.nickname
    self.send_to_twitter = true
  end

  def fetch_details_from_identity(auth)
  end

  def fetch_details_from_facebook(auth)
    names = auth.info.name.split
    self.first_name ||= names[0..-2].join(' ')
    self.last_name ||= names[-1]
    self.send_to_facebook = true
  end

  def fetch_details_from_instagram(auth)
    self.user_name ||= auth.info.nickname
    self.bio ||= auth.info.bio
  end

  def fetch_details_from_twitch(auth)
    names = auth.info.name.split
    self.first_name ||= names[0..-2].join(' ')
    self.last_name ||= names[-1]
    self.user_name ||= auth.info.nickname
  end

  # def fetch_details_from_github(auth)
  # end

  # def fetch_details_from_linkedin(auth)
  # end

  def fetch_details_from_google_oauth2(auth)
    self.first_name ||= auth.info.first_name
    self.last_name ||= auth.info.last_name
  end

  def twitter?
    oauthids.where(provider: 'twitter').any?
  end

  def twitter_posts?
    send_to_twitter && twitter?
    # super
  end

  def facebook?
    oauthids.where(provider: 'facebook').any?
  end

  def facebook_posts?
    send_to_facebook && facebook?
    # super
  end

  def google_oauth2?
    oauthids.where(provider: 'google_oauth2').any?
  end

  def instagram?
    oauthids.where(provider: 'instagram').any?
  end

  def twitch?
    oauthids.where(provider: 'twitch').any?
  end
end
