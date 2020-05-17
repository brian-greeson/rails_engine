require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'releationships' do

  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should have_many :items}
  end
  
  describe 'instance methods' do
    
  end
end
