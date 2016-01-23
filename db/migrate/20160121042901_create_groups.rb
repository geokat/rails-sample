class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.decimal :balance
      t.boolean :private

      t.timestamps null: false
    end
  end
end
