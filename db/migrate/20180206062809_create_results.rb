class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :score
      t.timestamps null: false
    end
  end
end
