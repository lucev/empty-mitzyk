class AddActiveToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :active, :boolean, default: true
    add_index :categories, :active
  end
end
