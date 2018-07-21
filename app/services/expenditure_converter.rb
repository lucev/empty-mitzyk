class ExpenditureConverter
  def initialize(user, params = {})

    @user = user
    @amount = params[:amount]
    @currency = params[:currency]
  end

  def converted_amount
    @amount.to_money(@currency).exchange_to(@user.default_currency).to_f
  end
end
