class RewardsMappingService
  REWARDS_FOR = {
      "MOVIES" => "PIRATES_OF_THE_CARIBBEAN_COLLECTION",
      "NEWS"   => nil,
      "MUSIC"  => "KARAOKE_PRO_MICROPHONE",
      "KIDS"   => nil,
      "SPORTS" => "CHAMPIONS_LEAGUE_FINAL_TICKET"
  }
  def call(channels)
    rewards = channels.map do |channel|
      reward_name = REWARDS_FOR[channel.channel_name]

      Reward.new(reward_name) unless reward_name.nil?
    end

    rewards.reject { |c| c.nil? }
  end
end