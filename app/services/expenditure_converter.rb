require 'money/bank/google_currency'
require 'monetize'

class ExpenditureConverter
  def initialize(user, params = {})
    Money.default_bank = Money::Bank::GoogleCurrency.new
    @user = user
    @amount = params[:amount]
    @currency = params[:currency]
  end

  def converted_amount
    @amount.to_money(@currency).exchange_to(@user.default_currency).to_f
  end
end
