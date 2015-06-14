class Reward
  attr :reward_name

  def initialize reward_name

    @reward_name = reward_name

  end

  def == another_reward
    self.reward_name == another_reward.reward_name
  end
end

