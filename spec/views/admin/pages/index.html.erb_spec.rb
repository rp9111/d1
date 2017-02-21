require 'rails_helper'
include ApplicationHelper

RSpec.describe "admin/pages/index", type: :view do
  before(:each) do
    @user = FactoryGirl.create :user
    @page1 = FactoryGirl.create :page, user: @user
    @page2 = FactoryGirl.create :page, user: @user
    assign(:pages, Kaminari.paginate_array([@page1, @page2]).page(1))
  end

  it 'renders a list of pages' do
    render
    assert_select 'tr>td[data-field="title"]', text: @page1.title.truncate(40)
    assert_select 'tr>td[data-field="permalink"]', text: @page1.permalink.truncate(10)
    assert_select "tr[data-id='#{@page1.id}']>td[data-field='commentable']", text: @page1.commentable ? 'Yes' : 'No'
    assert_select "tr[data-id='#{@page1.id}']>td[data-field='publish']", text: @page1.publish ? 'Yes' : 'No'
    assert_select 'tr>td[data-field="title"]', text: @page2.title.truncate(40)
    assert_select 'tr>td[data-field="permalink"]', text: @page2.permalink.truncate(10)
    assert_select "tr[data-id='#{@page2.id}']>td[data-field='commentable']", text: @page2.commentable ? 'Yes' : 'No'
    assert_select "tr[data-id='#{@page2.id}']>td[data-field='publish']", text: @page2.publish ? 'Yes' : 'No'
    assert_select 'tr>td[data-field="user_name"]', text: @user.name, count: 2
  end
end


