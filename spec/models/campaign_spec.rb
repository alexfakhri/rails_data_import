require 'rails_helper'

RSpec.describe Campaign, type: :model do

  before do
    campaign = Campaign.create(campaign: 'ssss_uk_01B')
  end

  it 'has a campagin id' do
    campaign = Campaign.last
    expect(campaign.campaign).to eq 'ssss_uk_01B'
  end

  it "should have many voyes" do
  campaign = Campaign.reflect_on_association(:votes)
  expect(campaign.macro).to eq(:has_many)
end
end
