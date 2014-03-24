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
    category = Category.new(:name => 'Traveling')
    category.name.should == 'Traveling'
  end
  
  it 'belongs to user' do
    user = User.create!(:email => 'foo@example.com')
    category = user.categories.build(:name => 'Transport')
    category.belongs_to?(user).should == true
  end

  it 'has position' do
    category = Category.new(:position => 2)
    category.position.should == 2
  end

  it 'should be invalid without a position' do
    category = Category.new(@valid_attributes.except(:position))
    category.should_not be_valid
  end
end
