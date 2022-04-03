class Restaurant < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :menus, inverse_of: :restaurant, dependent: :destroy
  accepts_nested_attributes_for :menus

  has_many :menu_items
  accepts_nested_attributes_for :menu_items
  
  has_many :placed_menu_items, -> { distinct }, through: :menus, source: :menu_items
end
