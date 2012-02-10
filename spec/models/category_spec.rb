require 'spec_helper'

describe Category do
  it 'can be instantiated' do
    Category.new.should be_instance_of(Category)
  end

  it 'has right attributes' do
    category = Category.new(:name => 'Traveling')
    category.name.should == 'Traveling'
  end
  
  it 'belongs to user' do
    user = User.create!(:email => 'foo@example.com')
    category = user.categories.build(:name => 'Transport')
    category.belongs_to?(user).should == true
  end
end
