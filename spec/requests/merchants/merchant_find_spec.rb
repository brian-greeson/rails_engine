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

    it 'Can fail to find an item by partial name' do
      merchant1 = create(:merchant)

      get "/api/v1/merchants/find?name=aaaaaaa"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expect(merchant["data"]).to eq(nil)
    end
  end


  describe 'Multi Results Finder' do
    after(:all) do
      Item.destroy_all
      Merchant.destroy_all
    end

   it 'Can find multiple merchants by partial args in the wrong case' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, name: "Taco")
      merchant3 = create(:merchant)
      merchant4 = create(:merchant, name: "acoTay")
      

      get "/api/v1/merchants/find_all?name=ACO"
      expect(response).to be_successful
      merchants = JSON.parse(response.body)
      
      expect(merchants["data"].count).to eq(2)
      expect(merchants["data"][0]["type"]).to eq("merchant")
      expect(merchants["data"][0]["id"]).to eq(merchant2.id.to_s)
      expect(merchants["data"][0]["attributes"]["name"]).to eq(merchant2.name)
    end
  end
end
