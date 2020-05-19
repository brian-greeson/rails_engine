require 'rails_helper'

describe 'Merchant API' do
  after(:all) do
    Item.destroy_all
    Merchant.destroy_all
  end

  it 'Response with details of all merchants' do
    merchant1 = create(:merchant)

    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants["data"][0]["id"]).to eq(merchant1.id.to_s)
    expect(merchants["data"][0]["type"]).to eq("merchant")
    expect(merchants["data"][0]["attributes"]["name"]).to eq(merchant1.name)

    create(:merchant)
    create(:merchant)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(merchants["data"].length).to eq(3)
  end

 it 'Can find a single merchant' do
    get "/api/v1/merchants/#{Faker::Number.number(digits: 3)}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]).to eq(nil) 

    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant1.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expect(merchant["data"]["type"]).to eq("merchant")
    expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
    expect(merchant["data"]["attributes"]["name"]).to eq(merchant1.name)
  end

 it 'Can delete a single merchant' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    delete "/api/v1/merchants/#{merchant1.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expect(merchant["data"]["type"]).to eq("merchant")
    expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
    expect(merchant["data"]["attributes"]["name"]).to eq(merchant1.name)

    delete "/api/v1/merchants/#{Faker::Number.number(digits: 3)}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]).to eq(nil)
  end

  it 'Can Create a new merchant' do
    merchant_to_make = build(:merchant)

    expect(Merchant.all).to be_empty

    post '/api/v1/merchants', params: {
      name: merchant_to_make.name,
    }

    expect(response).to be_successful
    expect(Merchant.first.name).to eq(merchant_to_make.name)
  end

  it 'Can Fail to Create a new record' do
    expect(Item.all).to be_empty
    
    post '/api/v1/merchants', params: {
      not_valid_attribute: 6
    }
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(Merchant.all).to be_empty
    expect(merchant["data"]).to eq(nil)
  end

  it 'Can update an existing record' do
    merchant1 = create(:merchant)
    merchant2 = build(:merchant)

    put "/api/v1/merchants/#{merchant1.id}", params: {
      name: merchant2.name
    }
    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expect(merchant["data"]["type"]).to eq("merchant")
    expect(merchant["data"]["id"]).to eq(merchant1.id.to_s)
    expect(merchant["data"]["attributes"]["name"]).to eq(merchant2.name)

    expect(Merchant.first.name).to eq(merchant2.name)
  end

  it 'Can list merchant items' do
    merchant1 = create(:merchant)
    item1 = merchant1.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant1.id}/items"
    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"][0]["type"]).to eq("item")
    expect(items["data"][0]["id"]).to eq(item1.id.to_s)
    expect(items["data"][0]["attributes"]["name"]).to eq(item1.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(item1.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(item1.unit_price.to_f)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(item1.merchant_id)

    merchant1.items.create(attributes_for(:item))
    merchant1.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant1.id}/items"
    items = JSON.parse(response.body)

    expect(items["data"].length).to eq(3)
  end

end
