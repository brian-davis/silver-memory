class Menu < ApplicationRecord
  validates :name, presence: true

  belongs_to :restaurant
  
  has_many :menu_menu_items, inverse_of: :menu, dependent: :destroy
  has_many :menu_items, through: :menu_menu_items, dependent: :destroy
  accepts_nested_attributes_for :menu_items
end
