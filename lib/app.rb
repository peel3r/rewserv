require 'sinatra/base'
require 'json'

require_relative '../lib/channel'
require_relative '../lib/reward'
require_relative '../lib/rewards_mapping_service'
require_relative '../lib/rewards_service'
require_relative '../lib/eligibility_service'
require_relative '../lib/invalid_account_number'

class App < Sinatra::Base
  set :server, :puma

  get '/' do
    "Rewards Service is RUNNING"
  end

  get "/available_rewards" do
    rewards_service = RewardsService.new(EligibilityService.new)
    subscriptions   = mapped_subscriptions(params["subscriptions"])

    available_rewards = rewards_service.check_for_rewards(params["account_nr"], subscriptions)
    available_rewards.to_json
  end

  private

  def mapped_subscriptions(channel)
    channel.collect { |name| Channel.new(name) }
  end
end