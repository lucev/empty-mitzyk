class Category < ActiveRecord::Base
  
  belongs_to :user
  has_many :expenditures

  validates_presence_of :name
  validates_presence_of :position
  
  def belongs_to? user
    self.user == user
  end
end
