require 'rails_helper'

describe 'profile' do
  describe 'user name' do
    before(:each) do
      FactoryGirl.create :area
    end
    it 'combines first and last names' do
      visit signup_path
      fill_in 'User name', with: 'olivia'
      fill_in 'Email', with: 'olivia@wilde.com'
      fill_in 'Password', with: 'password'
      submit_form
      fill_in 'First name', with: 'Olivia'
      fill_in 'Last name', with: 'Wilde'
      submit_form
      expect(User.last.name).to eq 'Olivia Wilde'
    end
  end
end
