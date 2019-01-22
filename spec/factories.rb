FactoryGirl.define do
  factory :user do
    default_currency 'USD'
    sequence(:email) { |n| "user_#{n}@example.com" }
  end

  factory :expenditure do
    association :category, factory: :category
    amount '3.99'
    date Date.today
  end

  factory :category do
    association :user, factory: :user
    name 'transportation'
    position 1
  end
end
