class Category < ActiveRecord::Base
  
  belongs_to :user
  has_many :expenditures

  validates_presence_of :name

  scope :active, -> { where(active: true) }
  
  def belongs_to? user
    self.user == user
  end
end
