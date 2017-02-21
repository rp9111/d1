require 'rails_helper'

describe 'signup' do
  describe 'via email' do
    before :each do
      visit signup_path
      fill_in 'User name', with: 'olivia'
      fill_in 'Email', with: 'olivia@wilde.com'
      fill_in 'Password', with: 'password'
    end
    it 'redirects to the profile page' do
      submit_form
      expect(page.current_path).to eq profile_path
    end
    it 'creates a new user' do
      expect { submit_form }.to change(User, :count).by(1)
    end
  end
end
