class AddSpendingLimitsToUser < ActiveRecord::Migration
  def change
    add_column :users, :weekly_limit, :decimal
    add_column :users, :monthly_limit, :decimal
  end
end
