class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.decimal :amount
      t.string :description
      t.date :date
      t.integer :category_id      
      t.integer :user_id

      t.timestamps
    end
  end
end
