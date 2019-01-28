module ExpendituresHelper

  def weekly_spending_status
    return '' if current_user.weekly_limit.nil?
    return 'green' if current_user.spent_this_week < current_user.lower_tolerance
    return 'red' if current_user.spent_this_week > current_user.upper_tolerance
    'yellow'
  end

  def month_percentage
    month_percentage = current_user.month_percentage
    if month_percentage > 100
      100
    else
      month_percentage
    end
  end

  def ofteness
    ["daily", "monthly", "extra"]
  end

  def progressbar_class
    if current_user.month_percentage < 80
      "progressbar_green"
    else
      "progressbar_yellow"
    end
  end

  def category_expenditures
    @expenditures.group(:category).reorder('sum_amount DESC').sum(:amount)
  end

  def expenditures_sum
    @expenditures.sum(:amount)
  end
end
