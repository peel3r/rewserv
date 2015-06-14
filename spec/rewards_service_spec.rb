require 'spec_helper'
require_relative '../lib/rewards_service'
require_relative '../lib/eligibility_service'
require_relative '../lib/invalid_account_number'
require_relative '../lib/rewards_mapping_service'

RSpec.describe RewardsService do
  let(:eligibility_service) { EligibilityService.new }
  subject { RewardsService.new(eligibility_service) }

  describe ".new" do
    it "provides eligibility_service" do
      expect(RewardsService.new(eligibility_service).eligibility_service).to eq(eligibility_service)
    end
    it "instantiates rewards mapper" do
      expect(RewardsService.new(eligibility_service).rewards_mapper).to be_a_kind_of(RewardsMappingService)
    end
  end

  describe ".check_for_rewards" do
    let(:account_nr)           { double }
    let(:subscriptions)        { double }
    let(:available_rewards)    {   []   }

    before do
      allow(eligibility_service).to receive(:check_for_rewards).and_return(eligibility)
    end

    context "customer is eligible for rewards" do
      let(:eligibility) { true }
      let(:subscriptions) { [ Channel.new("MOVIES"), Channel.new("SPORTS") ] }

      it "returns available rewards" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).not_to be_empty
      end

      it "check_RewardsMappingService for available rewards" do
        expect(subject.rewards_mapper).to receive(:call).with(subscriptions)
        subject.check_for_rewards(account_nr, subscriptions)
      end

      it "returns mapped rewards" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).
            to include("PIRATES_OF_THE_CARIBBEAN_COLLECTION","CHAMPIONS_LEAGUE_FINAL_TICKET")
      end

      it "returns mapped reward" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).
            to include("CHAMPIONS_LEAGUE_FINAL_TICKET")
      end

    end

    context "customer is not eligible for rewards" do
      let(:eligibility) { false }

      it "it doesn't return rewards" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).to be_empty
      end
    end

    context "technical failure exception" do
      let(:eligibility) { false }

      before do
        allow(eligibility_service).to receive(:check_for_rewards).and_raise(Exception)
      end

      it "it doesn't return rewards" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).to be_empty
      end
    end

    context "rised invalid account nr exception" do
      let(:eligibility) { false }

      before do
        allow(eligibility_service).to receive(:check_for_rewards).and_raise(InvalidAccountNumber)
      end

      it "it doesn't return rewards" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:available_rewards]).to be_empty
      end

      it "issues an error notification" do
        expect(RewardsService.new(eligibility_service).check_for_rewards(account_nr, subscriptions)[:error]).to eq("Invalid account nr, please provide a valid account nr")
      end
    end
  end
end