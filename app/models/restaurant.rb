class Restaurant < ApplicationRecord
  validates :name, presence: true

  has_many :menus
  has_many :menu_items, -> { distinct }, through: :menus
end
