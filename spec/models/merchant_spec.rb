require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'releationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
  
  describe 'instance methods' do
     it 'find_match' do
      merchant1 = create(:merchant)
      params = { name: merchant1.name[0..3].upcase }
      expect(Merchant.find_match(params)).to eq(merchant1)
    end
  end
end
