require 'rails_helper'

describe 'Signin' do
  describe 'via email and password' do

    before :each do
      @u = FactoryGirl.create :user, first_name: 'Olivia', last_name: 'Wilde', email: 'olivia@wilde.com', password: 'password'
      visit signin_path
    end

    it 'can sign in' do
      fill_in 'auth_key', with: 'olivia@wilde.com'
      fill_in 'password', with: 'password'
      submit_form
      expect(page).to_not have_css 'input#auth_key'
      expect(page).to_not have_css 'input#password'
    end

    it 'rejects invalid credentials' do
      fill_in 'auth_key', with: 'wrong@email.net'
      fill_in 'password', with: 'password'
      submit_form
      expect(page).to have_content 'The email or password is incorrect.'
      expect(page).to have_css 'input#auth_key'
      expect(page).to have_css 'input#password'
    end

    it 'requires an email' do
      fill_in 'password', with: 'password'
      submit_form
      expect(page).to have_css 'input#auth_key'
      expect(page).to have_css 'input#password'
    end

    it 'requires a password' do
      fill_in 'auth_key', with: 'olivia@wilde.com'
      submit_form
      expect(page).to have_css 'input#auth_key'
      expect(page).to have_css 'input#password'
    end

    it 'can signout' do
      fill_in 'auth_key', with: 'olivia@wilde.com'
      fill_in 'password', with: 'password'
      submit_form
      visit signout_path
      visit new_admin_page_path

      expect(page.current_path).to eq signin_path
    end

    it 'can reset the token by signing out' do
      fill_in 'auth_key', with: 'olivia@wilde.com'
      fill_in 'password', with: 'password'
      submit_form
      visit signout_path
      visit new_admin_page_path

      expect(page.current_path).to eq signin_path
    end

    it 'can reset the password by visiting reset' do
      visit reset_path 'olivia@wilde.com'

      expect(page.current_path).to eq root_path
    end

    it 'can complete the reset the password by visiting confirm' do
      visit reset_path 'olivia@wilde.com'
      @u.reload
      visit confirm_path @u.reset_token

      expect(page.current_path).to eq edit_user_path
    end

    it 'ignores invalid confirmations' do
      visit reset_path 'olivia@wilde.com'
      visit confirm_path 'wrong_confirmation'

      expect(page.current_path).to eq signin_path
    end
  end

  describe 'via oauth' do

    before :all do
      OmniAuth.config.test_mode = true
    end

    after :all do
      OmniAuth.config.test_mode = false
    end

    before :each do
      visit signin_path
    end

    it 'can sign in via twitter' do
      mock_twitter_auth_hash
      click_link 'Twitter'
      expect(page).to_not have_css 'input#auth_key'
      expect(page).to_not have_css 'input#password'
      expect(page.current_path).to eq profile_path
    end

    it 'can sign in via facebook' do
      mock_facebook_auth_hash
      click_link 'Facebook'
      expect(page).to_not have_css 'input#auth_key'
      expect(page).to_not have_css 'input#password'
      expect(page.current_path).to eq profile_path
    end

    it 'can sign in via google' do
      mock_google_oauth2_auth_hash
      click_link 'Google'
      expect(page).to_not have_css 'input#auth_key'
      expect(page).to_not have_css 'input#password'
      expect(page.current_path).to eq profile_path
    end

    it 'can sign in via instagram' do
      mock_instagram_auth_hash
      click_link 'Instagram'
      expect(page).to_not have_css 'input#auth_key'
      expect(page).to_not have_css 'input#password'
      expect(page.current_path).to eq profile_path
    end
  end

end
