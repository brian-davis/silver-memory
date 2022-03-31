class MenuMenuItemManyToMany < ActiveRecord::Migration[7.0]
  def up
    create_table :menu_menu_items do |t|
      t.references :menu
      t.references :menu_item
      t.timestamps
    end
    # destructive
    remove_reference(:menu_items, :menu)
  end

  def down
    add_reference(:menu_items, :menu, index: true)
    # destructive
    drop_table :menu_menu_items
  end
end