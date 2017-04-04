require 'rails_helper'

feature 'Expenditures' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category, name: 'Food', user: user) }

  before { login_as user, scope: :user }

  describe 'on home page' do
    before { visit new_user_registration_path }

    specify 'user sees monthly expenditures' do
      expect(page).to have_content 'Spent this month: 0.00 Kn'
    end
 
    specify 'user sees weekly expenditures' do
      expect(page).to have_content 'Spent this week: 0.00 Kn'
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

      expect(page).to have_content 'Spent this month: 42.00 Kn'
      expect(page).to have_content 'Spent this week: 42.00 Kn'
    end
  end

  describe 'on expenditures index page' do
    before do
      FactoryGirl.create(:expenditure, amount: 23.42, description: 'Bananas',
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
