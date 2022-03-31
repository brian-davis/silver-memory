require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "schema" do
    describe "name" do
      it do
        should(have_db_column(:name).of_type(:string).with_options({
          null: false
        }))
      end

      it "enforces presence at db level" do
        menu = FactoryBot.create(:menu_item)
        expect {
          menu.update_attribute(:name, nil)
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
        menu = FactoryBot.create(:menu_item)
        expect {
          menu.update_attribute(:price, nil)
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

  describe "validations" do
    it { should validate_presence_of(:price) }

    describe "name" do
      it { should validate_presence_of(:name) }

      it "is unique" do
        valid_menu_item = FactoryBot.create(:menu_item)
        invalid_menu_item = FactoryBot.build(:menu_item, {
          name: valid_menu_item.name
        })
        expect(invalid_menu_item).not_to be_valid
        errors = invalid_menu_item.errors.to_hash[:name] || []
        expect("has already been taken").to be_in(errors)
      end
    end

    describe "price" do
      it { should validate_presence_of(:price) }
    end
  end

  describe "associations" do
    it { should belong_to(:menu) }
  end
end
