class DenormalizeMenuItemRestaurant < ActiveRecord::Migration[7.0]
  def up
    add_reference(:menu_items, :restaurant)

    remove_index :menu_items, :name # with unique: true
    add_index :menu_items, [:name, :restaurant_id], unique: true
  end

  def down
    remove_reference(:menu_items, :restaurant)
    remove_index :menu_items, :name # [:name, restaurant_id]
    add_index :menu_items, :name, unique: true # global
  end
end

