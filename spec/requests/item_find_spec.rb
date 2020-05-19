require 'rails_helper'

describe 'Items Finder API' do
  describe 'Single Results Finder' do
    after(:all) do
      Item.destroy_all
      Merchant.destroy_all
    end

    it 'Can Find an item by name' do
      merchant1 = create(:merchant)
      item1 = merchant1.items.create(attributes_for(:item))

      get "/api/v1/items/find?name=#{item1.name}"
      expect(response).to be_successful
      item = JSON.parse(response.body)
      
      expect(item["data"]["type"]).to eq("item")
      expect(item["data"]["id"]).to eq(item1.id.to_s)
      expect(item["data"]["attributes"]["name"]).to eq(item1.name)
      expect(item["data"]["attributes"]["description"]).to eq(item1.description)
      expect(item["data"]["attributes"]["unit_price"]).to eq(item1.unit_price.to_f)
      expect(item["data"]["attributes"]["merchant_id"]).to eq(item1.merchant_id)
    end

    it 'Can find an item by partial name' do
      merchant1 = create(:merchant)
      item1 = merchant1.items.create(attributes_for(:item))

      get "/api/v1/items/find?name=#{item1.name[0..3]}"
      expect(response).to be_successful
      item = JSON.parse(response.body)

      expect(item["data"]["type"]).to eq("item")
      expect(item["data"]["id"]).to eq(item1.id.to_s)
      expect(item["data"]["attributes"]["name"]).to eq(item1.name)
      expect(item["data"]["attributes"]["description"]).to eq(item1.description)
      expect(item["data"]["attributes"]["unit_price"]).to eq(item1.unit_price.to_f)
      expect(item["data"]["attributes"]["merchant_id"]).to eq(item1.merchant_id)
    end
  end
end