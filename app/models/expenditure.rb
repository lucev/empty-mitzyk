class Expenditure < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates_presence_of :amount
  validates_presence_of :date

  scope :period, -> start_at, end_at { where("date >= ? AND date <= ?", start_at, end_at) }
  scope :period_start,  -> value { where("date >= ?", value) }
  scope :period_end,    -> value { where("date <= ?", value) }
  scope :category,      -> value { where("category_id = ?", value) }

  def owner? user
    self.user == user
  end
end
