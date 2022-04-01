require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "schema" do
    it do
      should(have_db_column(:name).of_type(:string).with_options({
        null: false
      }))
    end
  end

  describe "validations" do
    describe "name" do
      it { should validate_presence_of(:name) }

      it "enforces presence at db level" do
        menu = FactoryBot.create(:restaurant)
        expect {
          menu.update_attribute(:name, nil)
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

  describe "associations" do
    it { should have_many(:menus).dependent(:destroy) }

    describe "menu_items" do
      it { should have_many(:menu_items).through(:menus) }

      it "queries distinct records" do
        restaurant = FactoryBot.create(:restaurant)
        menu1 = FactoryBot.create(:menu, restaurant: restaurant)
        menu2 = FactoryBot.create(:menu, restaurant: restaurant)
        menu_item1 = FactoryBot.create(:menu_item)
        menu_item2 = FactoryBot.create(:menu_item)
        menu_item1.menus << menu1
        menu_item1.menus << menu2
        menu_item2.menus << menu1
        menu_item2.menus << menu2
        results = restaurant.menu_items
        expect(results.size).to eq(2)
        expect(menu_item1).to be_in(results)
        expect(menu_item2).to be_in(results)
      end
    end
  end
end
