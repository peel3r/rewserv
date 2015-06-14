require 'spec_helper'
require_relative "../lib/rewards_mapping_service"


RSpec.describe RewardsMappingService do

  describe " call " do
    context "when subscriptions are present" do
      let(:channels) { [ channel ] }

      shared_examples_for "reward mapper" do |channel, rewards|

        it "maps the rewards" do
          channels = [ Channel.new(channel) ]
          expect(RewardsMappingService.new.call(channels)).to eq(rewards)
        end
      end

      it_should_behave_like "reward mapper", "KIDS",   []
      it_should_behave_like "reward mapper", "NEWS",   []
      it_should_behave_like "reward mapper", "MOVIES", [ Reward.new("PIRATES_OF_THE_CARIBBEAN_COLLECTION") ]
      it_should_behave_like "reward mapper", "MUSIC",  [ Reward.new("KARAOKE_PRO_MICROPHONE") ]
      it_should_behave_like "reward mapper", "SPORTS", [ Reward.new("CHAMPIONS_LEAGUE_FINAL_TICKET") ]

      context "when 3 qualifying channels provided" do
        let(:channels) { [ Channel.new("SPORTS"), Channel.new("MOVIES"), Channel.new("MUSIC") ] }

        it "returns 3 rewards" do
          expect(RewardsMappingService.new.call(channels).length).to eq(3)
        end
      end

      context "when single qualifying channels provided" do
        let(:channels) { [  Channel.new("MUSIC") ] }

        it "returns 1 reward" do
          expect(RewardsMappingService.new.call(channels).length).to eq(1)
        end
      end
    end
  end


  context "when subscriptions are empty " do
    let(:channels) { [] }

    it "returns an empty collection" do
      expect(RewardsMappingService.new.call(channels)).to be_empty
    end
  end
end