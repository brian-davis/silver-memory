class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, index: true, null: false

      t.timestamps
    end
  end
end
