class RewardsService
  attr :eligibility_service, :rewards_mapper

  def initialize(eligibility_service)
    @eligibility_service = eligibility_service
    @rewards_mapper = RewardsMappingService.new
  end

  def check_for_rewards(account_number, subscriptions)
    begin
      if eligibility_service.check_for_rewards(account_number)
        available_rewards = rewards_mapper.call(subscriptions)
      end

    rescue InvalidAccountNumber
      error = "Invalid account nr, please provide a valid account nr"

    rescue Exception

    ensure
      available_rewards ||= []
      error ||= false
    end

    response(available_rewards, error)
  end

  private

  def response(available_rewards, error)
    {
        available_rewards: available_rewards.collect(&:reward_name) || [],
        error:   error
    }
  end
end