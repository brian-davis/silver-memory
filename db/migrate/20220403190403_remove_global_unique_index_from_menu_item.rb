class RemoveGlobalUniqueIndexFromMenuItem < ActiveRecord::Migration[7.0]
  def up
    remove_index :menu_items, :name # with unique: true
    add_index :menu_items, :name # without unique: true
  end

  def down
    remove_index :menu_items, :name # without unique: true
    add_index :menu_items, :name, unique: true
  end
end
