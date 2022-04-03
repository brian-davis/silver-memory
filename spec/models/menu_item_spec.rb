require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "schema" do
    let(:restaurant) {
      FactoryBot.create(:restaurant)
    }
    let(:menu_item) {
      FactoryBot.create(:menu_item, restaurant: restaurant)
    }

    describe "name" do
      it do
        should(have_db_column(:name).of_type(:string).with_options({
          null: false
        }))
      end

      it "enforces presence at db level" do
        expect {
          menu_item.update_attribute(:name, nil)
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end

    describe "price" do
      it do
        should have_db_column(:price).of_type(:decimal).with_options({
          null: false, precision: 10, scale: 2, default: 0.0
        })
      end

      it "enforces presence at db level" do
        expect {
          menu_item.update_attribute(:price, nil)
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

  describe "validations" do
    it { should validate_presence_of(:price) }

    describe "name" do
      it { should validate_presence_of(:name) }

      it "is unique per restaurant" do
        restaurant = FactoryBot.create(:restaurant)
        menu = FactoryBot.create(:menu, restaurant: restaurant)
        menu_item1 = FactoryBot.create(:menu_item, restaurant: restaurant)
        menu_item1.menus << menu
        invalid_menu_item = FactoryBot.build(:menu_item, {
          name: menu_item1.name,
          restaurant: restaurant
        })
        expect(invalid_menu_item).not_to be_valid
        errors = invalid_menu_item.errors.to_hash[:name] || []
        expect("has already been taken").to be_in(errors)

        restaurant2 = FactoryBot.create(:restaurant)
        valid_menu_item = FactoryBot.build(:menu_item, {
          name: menu_item1.name,
          restaurant: restaurant2
        })
        expect(valid_menu_item).to be_valid
      end
    end

    describe "price" do
      it { should validate_presence_of(:price) }
    end
  end

  describe "associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:menu_menu_items).dependent(:destroy) }
    it { should have_many(:menus).through(:menu_menu_items) }
  end
end
