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
    Expenditure.where("user_id = ? AND date >= ?", self.id, first_of_week)
  end
  
  def spent_this_week
    sum = (0.00).to_d
    self.week_expenditures.each do |expenditure|
      sum += expenditure.amount
    end
    return sum
  end
end
