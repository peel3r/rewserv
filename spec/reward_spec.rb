require "spec_helper"
require_relative "../lib/reward"

RSpec.describe Reward do
  let(:reward_name) { :REWARD_NAME }


  subject { Reward.new(reward_name) }

  describe ".new" do
    it "assigns names" do
      expect(subject.reward_name).to eq(reward_name)

    end
  end

  describe "compare" do
    context "when reward_names match" do
      it " match rewards " do
        expect(subject).to eq(Reward.new(reward_name))
      end
    end

    context "when reward_names do not match" do
      let(:other_reward) {:OTHER_REWARD}
      it " do not match rewards" do
        expect(subject).not_to eq(Reward.new(other_reward))
      end
    end
  end
end