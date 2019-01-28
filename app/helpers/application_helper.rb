module ApplicationHelper

  # First day of week, assuming that week begins on Monday
  def first_of_week
    Date.today.at_beginning_of_week
  end
  
  def first_of_month
    Date.today.at_beginning_of_month
  end

  def currencies
    Money::Currency.all.map(&:iso_code)
  end
end
