class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.integer :score
      t.string :name
      t.timestamps null: false
    end
  end
end
