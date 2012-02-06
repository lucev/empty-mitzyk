class AddTypeToExpenditure < ActiveRecord::Migration
  def change
    add_column :expenditures, :ofteness, :string
  end
end
