require 'spec_helper'
require 'date'

describe Expenditure do

  before :each do
    @valid_attributes = {:amount => 3.99, :date => Date.today}
  end

  it 'can be instantiated' do
    Expenditure.new.should be_instance_of(Expenditure)
  end
  
  it 'belongs to user' do
    expenditure = Expenditure.create!(:amount => 5.99)
    user = User.create!(:email => 'foo@example.com')
    expenditure.user = user
    expenditure.save
    
    user.expenditures.count.should == 1
  end
end
