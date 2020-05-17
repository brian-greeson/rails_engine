require 'rails_helper'

describe 'Items API' do
  it 'Response with details of all items' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)


    expect(items["data"][0]["name"]).to eq(merchant1.items.first.name)
    expect(items["data"][0]["description"]).to eq(merchant1.items.first.description)
    expect(items["data"][0]["unit_price"]).to eq(merchant1.items.first.unit_price.to_s)
    expect(items["data"][0]["merchant_id"]).to eq(merchant1.items.first.merchant_id)

    merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    get '/api/v1/items'
    items = JSON.parse(response.body)

    expect(items["data"].length).to eq(3)
  end  
end
