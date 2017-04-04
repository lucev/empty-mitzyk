class SetDefaultCurrency < ActiveRecord::Migration
  def up
    execute "UPDATE users SET default_currency = 'HRK'"
  end

  def down
    execute 'UPDATE users SET default_currency = NULL'
  end
end
