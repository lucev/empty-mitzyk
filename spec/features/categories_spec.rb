require 'rails_helper'

feature 'Categories' do
  let(:user) { FactoryBot.create(:user) }

  before { login_as user, scope: :user }

  describe 'on categories index page' do

    before do
      FactoryBot.create(:category, name: 'Transportation', user: user) 
      visit categories_path
    end

    specify 'user sees categories listing' do
      expect(page).to have_content 'Listing categories'
      expect(page).to have_content 'Transportation'
    end

    specify 'user creates new category' do
      click_link 'New Category'
      fill_in 'Name', with: 'Food'
      check 'Active'
      click_button 'Save'

      expect(page).to have_content 'Food'
    end

    specify 'user updates category' do
      click_link 'Transportation'
      fill_in 'Name', with: 'Accomodation'
      uncheck 'Active'
      click_button 'Save'

      expect(page).to have_content 'Accomodation'
      expect(page).to have_content 'Active: false'
    end
  end

  describe 'on home page' do
    let!(:active_category) { FactoryBot.create(:category, name: 'Active category', active: true, user: user) }
    let!(:inactive_category) { FactoryBot.create(:category, name: 'Inactive category', active: false, user: user) }

    before { visit root_path }

    specify 'user sees only active categories' do
      expect(page).to have_select 'Category', options: ['Active category']
    end
    
  end

end
