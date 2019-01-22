require 'rails_helper'

feature 'Settings' do
  let(:user) do
    FactoryBot.create(:user, monthly_limit: 100.00, weekly_limit: 20.00)
  end

  before { login_as user, scope: :user }

  describe 'on settings page' do
    before { visit settings_path }

    specify 'user sees settings form' do
      expect(page).to have_field 'Monthly limit'
      expect(page).to have_field 'Weekly limit'
      expect(page).to have_field 'Default currency'
    end

    specify 'user edits settings' do
      fill_in 'Monthly limit', with: 230.00
      fill_in 'Weekly limit', with: 35.00
      select 'HRK', from: 'Default currency'
      click_button 'Save'

      expect(page).to have_content 'Limits successfully set'
      expect(user.reload.monthly_limit).to eq 230.00
      expect(user.reload.weekly_limit).to eq 35.00
      expect(user.reload.default_currency).to eq 'HRK'
    end
  end
end
