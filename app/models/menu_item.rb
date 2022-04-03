class MenuItem < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true, uniqueness: {
    scope: :restaurant_id
  }
  validates :price, presence: true

  has_many :menu_menu_items, dependent: :destroy
  has_many :menus, through: :menu_menu_items
end
