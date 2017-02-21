require 'rails_helper'

RSpec.describe User, type: :model do
  it 'can be created' do
    user = FactoryGirl.create :user
    expect(user).to be_valid
  end

  describe 'attributes' do
    it 'has a full name' do
      user = FactoryGirl.build :user, first_name: 'Olivia', last_name: 'Wilde'
      expect(user.name).to eq 'Olivia Wilde'
    end

    it 'can create first and last names' do
      user = FactoryGirl.build :user, name: 'Olivia Wilde'

      expect(user.first_name).to eq 'Olivia'
      expect(user.last_name).to eq 'Wilde'
    end

    it 'downcases the email if it exists' do
      user = FactoryGirl.create :user, email: 'Olivia@Wilde.com'

      expect(user.email).to eq 'olivia@wilde.com'
    end
  end
end
