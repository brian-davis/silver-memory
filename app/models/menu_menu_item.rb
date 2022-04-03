class MenuMenuItem < ApplicationRecord
  belongs_to :menu
  belongs_to :menu_item, dependent: :destroy

  validates_presence_of :menu
  validates_presence_of :menu_item

  accepts_nested_attributes_for :menu_item
end
