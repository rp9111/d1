class Oauthid < ApplicationRecord
  belongs_to :user

  # after_create :fetch_details

  def self.from_auth(auth, user)
    return unless auth
    oauthid = Oauthid.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    populate oauthid, auth, (user || oauthid.user)
  end

  private

  def self.populate(oauthid, auth, user)
    return user unless oauthid.new_record?
    oauthid.provider = auth.provider
    oauthid.uid = auth.uid
    oauthid.token = auth.credentials.token
    # oauthid.image_url = auth.info.image
    oauthid.secret = auth.credentials.secret
    user ||= User.new
    user.fetch_details(auth)
    user.save(validate: false)
    oauthid.user = user
    oauthid.save
    oauthid.user
  end
end
