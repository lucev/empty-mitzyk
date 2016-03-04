require 'rails_helper'

describe User do
  it 'can be instantiated' do
    User.new.should be_an_instance_of(User)
  end
  
  it 'has right attributes' do
    user = User.create!(:email => 'foo@example.com')
    user.email.should == 'foo@example.com'
  end
  
  it 'calculates this week expenditures' do
    user = User.create!(:email => 'foo@example.com')
    
    expenditure_first = Expenditure.create!(:amount => 5.99, :date => Date.today - Date.today.wday+2,
                                            :ofteness => 'daily')
    expenditure_first.user = user
    expenditure_first.save
    
    expenditure_second = Expenditure.create!(:amount => 2, :date => Date.today - Date.today.wday+3,
                                             :ofteness => 'daily')
    expenditure_second.user = user
    expenditure_second.save
    
    user.spent_this_week.should == 7.99
  end  

  it 'has categories last position' do
    user = FactoryGirl.create(:user)

    category_travel = Category.create(:name => 'Travel', :position => 1)
    category_travel.user = user
    category_travel.save

    category_transportation = Category.create(:name => 'Transportation', :position => 2)
    category_transportation.user = user
    category_transportation.save

    user.categories_last_position.should == 2
  end
end
