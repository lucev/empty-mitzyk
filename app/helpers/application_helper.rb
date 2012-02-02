module ApplicationHelper

  # First day of week, assuming that week begins on Monday
  def first_of_week
    Date.today - Date.today.wday + 1
  end
  
  def first_of_month
    Date.today - Date.today.mday + 1
  end
end
