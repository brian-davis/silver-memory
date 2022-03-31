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
    it { should have_many(:menus) }
    it { should have_many(:menu_items).through(:menus) }
  end
end
