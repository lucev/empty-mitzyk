FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
  end

  factory :expenditure do
    amount '3.99'
    date Date.today
  end

  factory :category do
    name 'transportation'
    position 1
  end
end
