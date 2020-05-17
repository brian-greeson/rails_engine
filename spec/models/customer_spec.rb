require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'releationships' do

  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end
  
  describe 'instance methods' do
    
  end
end
