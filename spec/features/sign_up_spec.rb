require 'rails_helper'

feature 'Sign up' do
  scenario 'User signs up' do
    visit new_user_registration_path

    expect(page).to have_content('Sign up')

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
