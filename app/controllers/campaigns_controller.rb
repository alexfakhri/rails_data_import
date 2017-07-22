class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]

  def index
    @campaigns = Campaign.all
  end

  def show
    @votes = Vote.select("choice, sum(CASE WHEN validity != 'during' THEN 1 ELSE 0 end) uncounted_votes, sum(CASE WHEN validity = 'during' THEN 1 ELSE 0 end) valid_votes").where(campaign_id: @campaign.id).group(:choice)
  end


  private

    def set_campaign
      @campaign = Campaign.find(params[:id])
    end
end
