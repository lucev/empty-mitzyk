module ExpendituresHelper

  def weekly_spending_status
    if current_user.weekly_limit.nil?
      return ''
    end
    
    if current_user.spent_this_week < current_user.lower_tolerance
      return 'green'
    elsif current_user.spent_this_week > current_user.upper_tolerance
      return 'red'
    end
    else return 'yellow'
  end
  
end
