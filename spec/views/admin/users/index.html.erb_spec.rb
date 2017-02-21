require 'rails_helper'
include ApplicationHelper

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    @user1 = FactoryGirl.create :user, confirmed: true
    @user2 = FactoryGirl.create :user, confirmed: false
    assign(:users, Kaminari.paginate_array([ @user1, @user2 ]).page(1))
  end

  it "renders a list of users" do
    render
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='name']", text: @user1.name, count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='user_name']", text: @user1.user_name, count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='email']", text: @user1.email, count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='avatar']>img[src='#{@user1.avatar.to_s}']", count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='status']", text: @user1.status, count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='reset_at']", text: @user1.reset_at.to_s, count: 1
    assert_select "tr[data-id='#{@user1.id}']>td[data-field='confirmed']", text: 'Yes', count: 1

    assert_select "tr[data-id='#{@user2.id}']>td[data-field='name']", text: @user2.name, count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='user_name']", text: @user2.user_name, count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='email']", text: @user2.email, count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='avatar']>img[src='#{@user2.avatar.to_s}']", count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='status']", text: @user2.status, count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='reset_at']", text: @user2.reset_at.to_s, count: 1
    assert_select "tr[data-id='#{@user2.id}']>td[data-field='confirmed']", text: 'No', count: 1
  end
end
