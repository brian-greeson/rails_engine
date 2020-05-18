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

end
