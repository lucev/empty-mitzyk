module ExpendituresHelper

  def weekly_spending_status
    if current_user.weekly_limit.nil?
      return ''
    end
    # 10% +- tolerance in spending limits
    tolerance = 0.1
    expenditures = current_user.spent_this_week
    
    # assuming that first day of week is Monday, week day is 1 based instead of 0 based
    if expenditures < (current_user.weekly_limit/7)*((Date.today-1).wday+1)*(1-tolerance)
      return 'green'
    elsif expenditures > (current_user.weekly_limit/7)*((Date.today-1).wday+1)*(1+tolerance)
      return 'red'
    end
    else return 'yellow'
  end
  
end
