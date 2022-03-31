class Restaurant < ApplicationRecord
  validates :name, presence: true

  has_many :menus
end
