class User < ActiveRecord::Base
  include ApplicationHelper
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :categories
  has_many :expenditures
  
  def week_expenditures
    Expenditure.where("user_id = ? AND date >= ? AND ofteness = ?",
      self.id, first_of_week, 'daily')
  end
  
  def month_expenditures
    Expenditure.where("user_id = ? AND date >= ? AND ofteness = ? OR ofteness = ?",
      self.id, first_of_month, 'daily', 'monthly')
  end
  
  def month_percentage
    return 100 if self.monthly_limit.nil?
    ((self.spent_this_month / self.monthly_limit)*100).round(2)
  end

  def spent_this_week
    sum = (0.00).to_d
    self.week_expenditures.each do |expenditure|
      sum += expenditure.amount
    end
    return sum
  end
  
  def spent_this_month
    sum = (0.00).to_d
    self.month_expenditures.each do |expenditure|
      sum += expenditure.amount
    end
    return sum
  end
end
