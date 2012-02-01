class Expenditure < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates_presence_of :amount
  
  def owner? user
    self.user == user
  end
end
