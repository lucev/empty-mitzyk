class User < ActiveRecord::Base
  include ApplicationHelper
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :categories
  has_many :expenditures

  validates :default_currency, presence: true

  def week_expenditures
    expenditures.daily.
      period(Date.today.beginning_of_week, Date.today.end_of_week)
  end
  
  def month_expenditures
    expenditures.monthly.
      period(Date.today.beginning_of_month, Date.today.end_of_month)
  end
  
  def month_percentage
    return 100 if self.monthly_limit.nil?
    ((self.spent_this_month / self.monthly_limit)*100).round(2)
  end

  def spent_this_week
    week_expenditures.sum(:amount)
  end
  
  def spent_this_month
    month_expenditures.sum(:amount)
  end

  def available_this_month
    return 0 if monthly_limit.blank?

    monthly_limit - spent_this_month
  end

  def available_this_week
    return 0 if weekly_limit.blank?

    weekly_limit - spent_this_week
  end

  def lower_tolerance
    (weekly_limit / 7) * Date.today.wday * (1 - Rails.configuration.limit_tolerance)
  end

  def upper_tolerance
    (weekly_limit / 7) * Date.today.wday * (1 + Rails.configuration.limit_tolerance)
  end

  def categories_last_position
    self.categories.order(:position).last.position
  end
end
