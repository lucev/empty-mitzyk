class AddDefaultCurrencyToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_currency, :string, default: 'USD'
  end
end
