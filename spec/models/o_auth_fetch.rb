require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = FactoryGirl.create :user
    FactoryGirl.create :oauthid, provider: 'twitter', user: @user
    FactoryGirl.create :oauthid, provider: 'facebook', user: @user
  end

  it 'responds to the twitter? method' do
    expect(@user.twitter?).to be true
  end

  it 'send to twitter can turned on' do
    @user.send_to_twitter = true
    expect(@user.twitter_posts?).to be true
  end

  it 'send to twitter can turned off' do
    @user.send_to_twitter = false
    expect(@user.twitter_posts?).to be false
  end

  it 'responds to the facebook? method' do
    expect(@user.facebook?).to be true
  end

  it 'send to facebook can turned on' do
    @user.send_to_facebook = true
    expect(@user.facebook_posts?).to be true
  end

  it 'send to facebook can turned off' do
    @user.send_to_facebook = false
    expect(@user.facebook_posts?).to be false
  end

end
