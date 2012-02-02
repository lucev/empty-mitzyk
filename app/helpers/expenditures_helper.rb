module ExpendituresHelper

  def weekly_spending_status
    if current_user.weekly_limit.nil?
      return ''
    end
    
    # 10% +- tolerance in spending limits
    tolerance = 0.1
    expenditures = current_user.spent_this_week
    
    if expenditures*(1+tolerance) < (current_user.weekly_limit/7)*Date.today.wday
      return 'green'
    elsif expenditures*(1-tolerance) > (current_user.weekly_limit/7)*Date.today.wday
      return 'red'
    end
    else return 'yellow'
  end
end
