module ExpendituresHelper

  def weekly_spending_status
    return '' if current_user.weekly_limit.nil?
    return 'green' if current_user.spent_this_week < current_user.lower_tolerance
    return 'red' if current_user.spent_this_week > current_user.upper_tolerance
    'yellow'
  end
end
