class Menu < ApplicationRecord
  validates :name, presence: true

  belongs_to :restaurant
  
  has_many :menu_menu_items, class_name: MenuMenuItem.name, dependent: :destroy
  has_many :menu_items, through: :menu_menu_items
end
