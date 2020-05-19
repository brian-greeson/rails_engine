require 'rails_helper'

describe 'Items API' do
  after(:all) do
    Item.destroy_all
    Merchant.destroy_all
  end

  it 'Response with details of all items' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(merchant1.items.first.id.to_s)
    expect(items["data"][0]["attributes"]["name"]).to eq(merchant1.items.first.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(merchant1.items.first.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(merchant1.items.first.unit_price.to_f)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(merchant1.items.first.merchant_id)

    merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    get '/api/v1/items'
    items = JSON.parse(response.body)

    expect(items["data"].length).to eq(3)
  end 

  it 'Can find a single record' do
    get "/api/v1/items/#{Faker::Number.number(digits: 3)}"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]).to eq(nil)

    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))


    get "/api/v1/items/#{item1.id}"
    expect(response).to be_successful
    item = JSON.parse(response.body)

    expect(item["data"]["type"]).to eq("item")
    expect(item["data"]["id"]).to eq(item1.id.to_s)
    expect(item["data"]["attributes"]["name"]).to eq(item1.name)
    expect(item["data"]["attributes"]["description"]).to eq(item1.description)
    expect(item["data"]["attributes"]["unit_price"]).to eq(item1.unit_price.to_f)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(item1.merchant_id)
  end

  it 'Can Delete a record' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))

    delete "/api/v1/items/#{item1.id}"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    merchant1.reload

    expect(item["data"]["type"]).to eq("item")
    expect(item["data"]["id"]).to eq(item1.id.to_s)
    expect(item["data"]["attributes"]["name"]).to eq(item1.name)
    expect(item["data"]["attributes"]["description"]).to eq(item1.description)
    expect(item["data"]["attributes"]["unit_price"]).to eq(item1.unit_price.to_f)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(item1.merchant_id)
    expect(merchant1.items).to be_empty

    delete "/api/v1/items/#{Faker::Number.number(digits: 3)}"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]).to eq(nil)
  end

  it 'Can Create a new record' do
    merchant1 = create(:merchant)
    item_to_make = build(:item, merchant_id: merchant1.id)

    expect(Item.all).to be_empty

    post '/api/v1/items', params: {
      name: item_to_make.name,
      description: item_to_make.description,
      unit_price: item_to_make.unit_price,
      merchant_id: item_to_make.merchant_id
    }
    expect(response).to be_successful
    
    expect(Item.first.name).to eq(item_to_make.name)
    expect(Item.first.description).to eq(item_to_make.description)
    expect(Item.first.unit_price.to_f).to eq(item_to_make.unit_price.to_f)
    expect(Item.first.merchant_id).to eq(item_to_make.merchant_id)
  end

  it 'Can Fail to Create a new record' do
    merchant1 = create(:merchant)
    item_to_make = build(:item)

    expect(Item.all).to be_empty
    
    post '/api/v1/items', params: {
      name: item_to_make.name,
      description: item_to_make.description,
      unit_price: item_to_make.unit_price,
      merchant_id: item_to_make.merchant_id
    }

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(Item.all).to be_empty
    expect(item["data"]).to eq(nil)
  end

  it 'Can update an existing record' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))
    item2 = build(:item, merchant_id: merchant1.id)

    put "/api/v1/items/#{item1.id}", params: {
      id: item1.id,
      name: item2.name,
      description: item2.description,
      unit_price: item2.unit_price,
      merchant_id: item2.merchant_id
    }
    expect(response).to be_successful
    item = JSON.parse(response.body)

    expect(item["data"]["type"]).to eq("item")
    expect(item["data"]["id"]).to eq(item1.id.to_s)
    expect(item["data"]["attributes"]["name"]).to eq(item2.name)
    expect(item["data"]["attributes"]["description"]).to eq(item2.description)
    expect(item["data"]["attributes"]["unit_price"]).to eq(item2.unit_price.to_f)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(item2.merchant_id)

    expect(Item.first.name).to eq(item2.name)
  end

  
end
