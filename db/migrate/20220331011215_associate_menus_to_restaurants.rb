class AssociateMenusToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :restaurant, index: true
  end
end
