require 'rails_helper'

feature 'campaigns' do

  context "visiting the campagin page" do

    before do
      Campaign.create(campaign: 'ssss_uk_01B')
      visit '/'
    end

    scenario "should show the campaign name" do
      expect(page).to have_content 'ssss_uk_01B'
    end

    scenario "should have a link to the view the campaign" do
      expect(page).to have_link 'Show'
    end
  end
end
