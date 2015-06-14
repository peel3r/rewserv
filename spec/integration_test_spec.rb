require 'spec_helper'
require_relative '../lib/rewards_service'

RSpec.describe "rewards_service" do
  include Rack::Test::Methods

  def app
    App
  end

  describe '/' do
    it  do
      get '/'

      expect(last_response).to be_ok
    end
  end

  describe "/available_rewards" do
    let(:params) do
      {
          account_nr: "ab12",
          subscriptions: [ "MUSIC", "KIDS",  "SPORTS" ]
      }
    end

    it "returns 200" do
      get "/available_rewards", params
      expect(last_response).to be_ok
    end

    it "returns false" do
      get "/available_rewards", params

      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response["error"]).to eq(false)
    end

    it "returns available rewards" do
      get "/available_rewards", params

      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response["available_rewards"]).to include("KARAOKE_PRO_MICROPHONE", "CHAMPIONS_LEAGUE_FINAL_TICKET")
    end
  end

end