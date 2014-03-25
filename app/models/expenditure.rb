class Expenditure < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates_presence_of :amount
  validates_presence_of :date
  
  def owner? user
    self.user == user
  end
end
