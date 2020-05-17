require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'releationships' do
    it { should belong_to :merchant }
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many :transactions}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :customer_id }
    it { should define_enum_for(:status).with_values([:pending, :fulfilled, :shipped, :canceled])}
  end
  
  describe 'instance methods' do
    
  end
end
