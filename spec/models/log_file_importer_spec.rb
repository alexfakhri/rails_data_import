require 'rails_helper'

RSpec.describe LogFileImporter do

  describe 'initialize' do
    let(:subject) { described_class.new('./spec/fixtures/votes.txt') }

    it 'initializes with a file' do
      expect(subject.file).to eq './spec/fixtures/votes.txt'
    end
  end

  describe 'run' do
      let(:subject) { described_class.new('./spec/fixtures/somefile.txt') }

    it 'returns an error if no file is given' do
      expect(STDOUT).to receive(:puts).with("file not found")
      subject.run
    end
  end

  describe 'parse data' do
    let(:subject) { described_class.new('./spec/fixtures/votes.txt') }

    it 'validates and parses the required data from the given line if it matches' do
      line = 'VOTE 1168041805 Campaign:ssss_uk_01B Validity:during Choice:Antony CONN:MIG01TU MSISDN:00777778359999 GUID:E6109CA1-7756-45DC-8EE7-677CA7C3D7F3 Shortcode:63334'
      data = subject.parse_data(line)
      expect(data[:time]).to eq '1168041805'
      expect(data[:validity]).to eq 'during'
      expect(data[:choice]).to eq 'Antony'
      expect(data[:campaign]).to eq 'ssss_uk_01B'
    end

    it 'returns nill if the data does not match' do
      line = 'VOTE 1168042652 Campaign:Emmerdale Validity:during Choice:GRAYSON CONN:MIG01OU MSISDN:00777771739999 GUID:36E30841-0B9A-47FF-9A13-AA97A27A2E18 Shortcode:63339'
      expect(subject.parse_data(line)).to eq nil
    end
  end

  describe 'parse data' do
    let(:subject) { described_class.new('./spec/fixtures/votes.txt') }

    before do
      line = 'VOTE 1168041805 Campaign:ssss_uk_01B Validity:during Choice:Antony CONN:MIG01TU MSISDN:00777778359999 GUID:E6109CA1-7756-45DC-8EE7-677CA7C3D7F3 Shortcode:63334'
      data = subject.parse_data(line)
      subject.write_to_table(data)
    end

    it 'creates or finds the campaign passed in' do
      campaign = Campaign.last
      expect(campaign.campaign).to eq 'ssss_uk_01B'
    end

    it 'creates a new vote' do
      campaign = Campaign.last
      vote = Vote.last
      expect(vote.epoch_time_value).to eq 1168041805
      expect(vote.validity).to eq 'during'
      expect(vote.choice).to eq 'Antony'
      expect(vote.campaign_id).to eq campaign.id
    end
  end
end
