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
    expect(items["data"][0]["id"]).to eq(merchant1.items.first.id)
    expect(items["data"][0]["attributes"]["name"]).to eq(merchant1.items.first.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(merchant1.items.first.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(merchant1.items.first.unit_price.to_s)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(merchant1.items.first.merchant_id)

    merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    get '/api/v1/items'
    items = JSON.parse(response.body)

    expect(items["data"].length).to eq(3)
  end 

  it 'Can find a single record' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))


    get "/api/v1/items/#{item1.id}"
    expect(response).to be_successful
    item = JSON.parse(response.body)

    expect(item["data"]["type"]).to eq("item")
    expect(item["data"]["id"]).to eq(item1.id)
    expect(item["data"]["attributes"]["name"]).to eq(item1.name)
    expect(item["data"]["attributes"]["description"]).to eq(item1.description)
    expect(item["data"]["attributes"]["unit_price"]).to eq(item1.unit_price.to_s)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(item1.merchant_id)
  end
end
