require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  it 'can be instantiated' do
    User.new.should be_an_instance_of(User)
  end

  it { should validate_presence_of(:default_currency) }
  
  it 'calculates this week expenditures' do
    Expenditure.create!(amount: 5.99, date: Date.today - Date.today.wday + 2,
                        ofteness: 'daily', user: user)
    Expenditure.create!(amount: 2, date: Date.today - Date.today.wday + 3,
                        ofteness: 'daily', user: user)
    
    user.spent_this_week.should == 7.99
  end  

  it 'has categories last position' do
    category_travel = Category.create(:name => 'Travel', :position => 1)
    category_travel.user = user
    category_travel.save

    category_transportation = Category.create(:name => 'Transportation', :position => 2)
    category_transportation.user = user
    category_transportation.save

    user.categories_last_position.should == 2
  end
end
