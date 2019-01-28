require 'rails_helper'

feature 'Expenditures' do
  let(:user) { FactoryBot.create(:user, monthly_limit: 100.00, weekly_limit: 30.00) }
  let!(:category) { FactoryBot.create(:category, name: 'Food', user: user) }
  let!(:expenditure) { FactoryBot.create(:expenditure, amount: 20.00, ofteness: 'daily', user: user, category: category) }

  before do
    login_as user, scope: :user
  end

  describe 'on home page' do
    before { visit new_user_registration_path }

    specify 'user sees monthly expenditures' do
      expect(page).to have_content 'Spent this month: 20.00 Kn'
    end
 
    specify 'user sees weekly expenditures' do
      expect(page).to have_content 'Spent this week: 20.00 Kn'
    end

    specify 'user sees available money' do
      expect(page).to have_content '(80.00 Kn available)'
    end

    specify 'user sees available money' do
      expect(page).to have_content '(10.00 Kn available)'
    end

    specify 'user sees new expenditure form' do
      expect(page).to have_field 'Amount'
      expect(page).to have_field 'Currency'
      expect(page).to have_field 'Category'
      expect(page).to have_field 'Description' 
      expect(page).to have_field 'Limit'
      expect(page).to have_field 'Date'
      expect(page).to have_button 'Save'
    end

    specify 'user creates new expenditure' do
      fill_in 'Amount', with: 42.00
      select  'Food', from: 'Category'
      fill_in 'Description', with: 'Bananas'
      select  'daily', from: 'Limit'
      fill_in 'Date', with: Date.today
      click_button 'Save'

      expect(page).to have_content 'Spent this month: 62.00 Kn'
      expect(page).to have_content 'Spent this week: 62.00 Kn'
    end
  end

  describe 'on expenditures index page' do
    before do
      FactoryBot.create(:expenditure, amount: 23.42, description: 'Bananas',
                                      category: category, user: user)
      visit expenditures_path
    end

    specify 'user sees expenditures listing' do
      expect(page).to have_content 'Expenditures listing'
      expect(page).to have_content '23.42 Kn'
      expect(page).to have_content 'Bananas'
    end
  end
end
