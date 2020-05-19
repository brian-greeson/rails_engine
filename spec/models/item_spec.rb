require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'releationships' do
    it {should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end
  
  describe 'instance methods' do
    it 'find_match' do
      merchant1 = create(:merchant)
      item1 = merchant1.items.create(attributes_for(:item))
      params = { name: item1.name[0..3], description: item1.description[2..8] }
      expect(Item.find_match(params)).to eq(item1)
      
    end
  end
end
