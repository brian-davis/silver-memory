require 'rails_helper'

RSpec.describe MenuMenuItem, type: :model do
  describe "associations" do
    it { should belong_to(:menu) }
    it { should belong_to(:menu_item) }
  end
end
