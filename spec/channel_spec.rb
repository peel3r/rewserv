require "spec_helper"
require_relative "../lib/channel"

RSpec.describe Channel do
  let(:channel_name) { double }

  subject { Channel.new(channel_name) }

  describe ".new" do
    it "assigns names" do
      expect(subject.channel_name).to eq(channel_name)
    end
  end


end
