class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name, index: true, unique: true, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.references :menu

      t.timestamps
    end
  end
end
