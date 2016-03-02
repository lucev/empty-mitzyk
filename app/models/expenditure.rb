class Expenditure < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates_presence_of :amount
  validates_presence_of :date

  scope :period_start,  -> value { where("date >= ?", value) }
  scope :period_end,    -> value { where("date <= ?", value) }

  def owner? user
    self.user == user
  end
end
