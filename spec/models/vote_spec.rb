require 'rails_helper'

RSpec.describe Vote, type: :model do

  before do
    campaign = Campaign.create(campaign: 'ssss_uk_01B')
    vote = Vote.create(epoch_time_value: 1168041805, validity: 'during', choice: 'Antony', campaign: campaign)
  end

  it 'has an epoch time value' do
    vote = Vote.last
    expect(vote.epoch_time_value).to eq 1168041805
  end

  it 'has a validity' do
    vote = Vote.last
    expect(vote.validity).to eq 'during'
  end

  it 'has a choice' do
    vote = Vote.last
    expect(vote.choice).to eq 'Antony'
  end

  it 'has a campaign' do
    campaign = Campaign.last
    vote = Vote.last
    expect(vote.campaign_id).to eq campaign.id
  end

  it "belongs to campagin" do
    vote = Vote.reflect_on_association(:campaign)
    expect(vote.macro).to eq(:belongs_to)
  end
end
