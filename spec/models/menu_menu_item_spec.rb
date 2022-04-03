require 'rails_helper'

RSpec.describe MenuMenuItem, type: :model do
  describe "associations" do
    it { should belong_to(:menu) }
    it { should belong_to(:menu_item).dependent(:destroy) }

    it "is a many-to-many join" do
      restaurant = FactoryBot.create(:restaurant)
      menu1 = FactoryBot.create(:menu, restaurant: restaurant)
      menu2 = FactoryBot.create(:menu, restaurant: restaurant)
      menu_item1 = FactoryBot.create(:menu_item, restaurant: restaurant)
      menu_item2 = FactoryBot.create(:menu_item, restaurant: restaurant)
      menu_item1.menus << menu1
      menu_item1.menus << menu2
      menu_item2.menus << menu1
      menu_item2.menus << menu2
      expect(menu_item1).to be_in(menu1.menu_items)
      expect(menu_item2).to be_in(menu1.menu_items)
      expect(menu_item1).to be_in(menu2.menu_items)
      expect(menu_item2).to be_in(menu2.menu_items)
      expect(menu1).to be_in(menu_item1.menus)
      expect(menu1).to be_in(menu_item2.menus)
      expect(menu2).to be_in(menu_item1.menus)
      expect(menu2).to be_in(menu_item2.menus)
    end
  end
end
