class Expenditure < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  
  validates_presence_of :amount
  validates_presence_of :date

  attr_accessor :currency

  scope :period, -> start_at, end_at { where("date >= ? AND date <= ?", start_at, end_at) }
  scope :period_start,  -> value { where("date >= ?", value) }
  scope :period_end,    -> value { where("date <= ?", value) }
  scope :category,      -> value { where("category_id = ?", value) }
  scope :daily,         -> { where ofteness: 'daily' }
  scope :monthly,       -> { where('ofteness = ? OR ofteness = ?', 'daily', 'monthly') }

  def owner? user
    self.user == user
  end
end
