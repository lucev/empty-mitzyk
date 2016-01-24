require 'spec_helper'

describe Category do

  before(:each) do
    @valid_attributes = {
      :name => 'Traveling',
      :position => 2
    }
  end

  it 'can be instantiated' do
    Category.new.should be_instance_of(Category)
  end

  it 'has right attributes' do
    category = Category.new(@valid_attributes)
    category.name.should == 'Traveling'
    category.position.should == 2
  end
  
  it 'belongs to user' do
    user = User.create!(:email => 'foo@example.com')
    category = user.categories.build(:name => 'Transport')
    category.belongs_to?(user).should == true
  end

  it 'should be invalid without a name' do
    category = Category.new(@valid_attributes.except(:name))
    category.should_not be_valid
  end
end
