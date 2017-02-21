require 'rails_helper'

describe 'Impressions' do

  describe 'visiting an page' do

    before :each do
      @page = FactoryGirl.create :page
    end

    it 'initially has no impressions' do
      expect(@page.impressions_count).to eq 0
    end

    it 'creates an impression' do
      visit area_path @page.area
      @page.reload
      expect(@page.impressions_count).to eq 1
    end

    it 'creates only one impression per user' do
      visit area_path @page.area
      visit signup_path
      visit area_path @page.area

      @page.reload
      expect(@page.impressions_count).to eq 1
    end

    it 'increments for different users' do
      visit area_path @page.area
      signed_in_admin_js
      visit area_path @page.area

      @page.reload
      expect(@page.impressions_count).to eq 2
    end

    it 'shows the impression count on page#show' do
      visit area_path @page.area
      signed_in_admin_js

      visit admin_page_path @page
      expect(page).to have_content 'Views: 1'
    end

    it 'shows the impression count on page#index' do
      visit area_path @page.area
      signed_in_admin_js

      visit admin_pages_path
      expect(page).to have_css "tr[data-id='#{@page.id}'] td[data-field='impressions_count']", text: '1'
    end

  end

end
