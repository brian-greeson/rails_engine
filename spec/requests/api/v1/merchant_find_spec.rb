require 'rails_helper'

describe 'Merchant Finder API' do
  describe 'Single Results Finder' do
    after(:all) do
      Item.destroy_all
      Merchant.destroy_all
    end

    it 'Can Find a merchant by name' do
      merchant1 = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant1.name}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"]["type"]).to eq("merchant")
      expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
      expect(merchant["data"]["attributes"]["name"]).to eq(merchant1.name)
    end

    it 'Can find an item by partial name' do
      merchant1 = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant1.name[0..3]}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expect(merchant["data"]["type"]).to eq("merchant")
      expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
      expect(merchant["data"]["attributes"]["name"]).to eq(merchant1.name)
    end
  end
end
