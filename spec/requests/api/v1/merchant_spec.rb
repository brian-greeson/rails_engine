require 'rails_helper'

describe 'Merchant API' do
  it 'Response with details of all merchants' do
    merchant1 = create(:merchant)

    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)



    expect(merchants["data"][0]["id"]).to eq(merchant1.id)
    expect(merchants["data"][0]["type"]).to eq("merchant")
    expect(merchants["data"][0]["attributes"]["name"]).to eq(merchant1.name)

    create(:merchant)
    create(:merchant)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(merchants["data"].length).to eq(3)
  end  
end
