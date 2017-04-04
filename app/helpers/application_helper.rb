module ApplicationHelper

  # First day of week, assuming that week begins on Monday
  def first_of_week
    Date.today - (Date.today-1).wday
  end
  
  def first_of_month
    Date.today - Date.today.mday + 1
  end

  def currencies
    Money::Currency.all.map{ |c| c.iso_code }
  end
end
