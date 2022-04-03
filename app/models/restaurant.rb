class Restaurant < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :menus, dependent: :destroy

  has_many :menu_items, -> { distinct }, through: :menus
end
