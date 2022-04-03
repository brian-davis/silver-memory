class MenuItem < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  has_many :menu_menu_items, dependent: :destroy
  has_many :menus, through: :menu_menu_items
end
