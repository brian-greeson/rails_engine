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

    it 'Can find an item by multiple and partial args in the wrong case' do
      merchant1 = create(:merchant)
      item1 = merchant1.items.create(attributes_for(:item))

      get "/api/v1/items/find?name=notgonnafindme&description=#{item1.description[3..8].upcase}"
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

  describe 'Multi Results Finder' do
    after(:all) do
      Item.destroy_all
      Merchant.destroy_all
    end

   it 'Can find multiple items by multiple and partial args in the wrong case' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = merchant1.items.create(attributes_for(:item))
      item2 = merchant1.items.create(attributes_for(:item, name: "Mr. taco"))
      item3 = merchant2.items.create(attributes_for(:item))
      item4 = merchant2.items.create(attributes_for(:item, description: "Burrito"))

      get "/api/v1/items/find_all?name=TACO&description=buRRito"
      expect(response).to be_successful
      items = JSON.parse(response.body)
      
      expect(items["data"].count).to eq(2)
      expect(items["data"][0]["type"]).to eq("item")
      expect(items["data"][0]["id"]).to eq(item2.id.to_s)
      expect(items["data"][0]["attributes"]["name"]).to eq(item2.name)
      expect(items["data"][0]["attributes"]["description"]).to eq(item2.description)
      expect(items["data"][0]["attributes"]["unit_price"]).to eq(item2.unit_price.to_f)
      expect(items["data"][0]["attributes"]["merchant_id"]).to eq(item2.merchant_id)
    end
  end
end