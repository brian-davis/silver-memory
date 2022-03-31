class Menu < ApplicationRecord
  validates :name, presence: true

  has_many :menu_items
  belongs_to :restaurant
end
