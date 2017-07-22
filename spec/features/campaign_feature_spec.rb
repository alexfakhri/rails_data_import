require 'rails_helper'

feature 'campaigns' do

  before do
    @campaign = Campaign.create(campaign: 'ssss_uk_01B')
    visit '/'
  end

  context "visiting the campaign index page" do

    scenario "should show the campaign name" do
      expect(page).to have_content 'ssss_uk_01B'
    end

    scenario "should have a link to the view the campaign" do
      expect(page).to have_link 'Show'
    end
  end

  context "visiting the campaign show page" do

    before do
      Vote.create(epoch_time_value: 1168041805, validity: 'during', choice: 'Antony', campaign: @campaign)
      Vote.create(epoch_time_value: 1168041805, validity: 'pre', choice: 'Antony', campaign: @campaign)
      Vote.create(epoch_time_value: 1168041805, validity: 'post', choice: 'Antony', campaign: @campaign)
      visit campaign_path(@campaign)
    end

    scenario "it displays the choice" do
      expect(page).to have_content 'Antony'
    end

    scenario "it displays the number of valid votes" do
      expect(page).to have_content 1
    end

    scenario "it displays the number of uncounted votes" do
      expect(page).to have_content 2
    end
  end
end
