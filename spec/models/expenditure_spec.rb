require 'rails_helper'
require 'date'

describe Expenditure do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    @valid_attributes = {:amount => 3.99, :date => Date.today}
  end

  it 'can be instantiated' do
    Expenditure.new.should be_instance_of(Expenditure)
  end
  
  it 'belongs to user' do
    expenditure = FactoryGirl.build(:expenditure)
    expenditure.user = user
    expenditure.save
    
    user.expenditures.count.should == 1
  end

  it 'should be invalid without amount' do
    expenditure = Expenditure.new(@valid_attributes.except(:amount))
    expenditure.should_not be_valid
  end

  it 'should be invalid without date' do
    expenditure = Expenditure.new(@valid_attributes.except(:date))
    expenditure.should_not be_valid
  end
end
