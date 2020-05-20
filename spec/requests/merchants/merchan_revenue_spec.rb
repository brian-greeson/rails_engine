require 'rails_helper'

describe 'Merchant Revenue API' do
  describe 'Merchants with Most Revenue' do
    after(:all) do
      Item.destroy_all
      Merchant.destroy_all
    end

    it 'Can return variable number of merchants ranked by total revenue' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      customer = create(:customer)

      item1 = merchant1.items.create(attributes_for(:item))
      item2 = merchant1.items.create(attributes_for(:item))
      item3 = merchant1.items.create(attributes_for(:item))
      item4 = merchant2.items.create(attributes_for(:item))
      item5 = merchant3.items.create(attributes_for(:item))

      invoice1 = create(:invoice, customer: customer, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer, merchant: merchant1)
      invoice3 = create(:invoice, customer: customer, merchant: merchant2)
      invoice4 = create(:invoice, customer: customer, merchant: merchant3)

      create(:invoice_item, item: item1 , invoice: invoice1 , unit_price: 1.5)
      create(:invoice_item, item: item2 , invoice: invoice1 , unit_price: 1.5)
      create(:invoice_item, item: item3 , invoice: invoice1 , unit_price: 1.5)

      create(:invoice_item, item: item1 , invoice: invoice2 , unit_price: 1.5)

      create(:invoice_item, item: item4 , invoice: invoice3 , unit_price: 1.5)

      create(:invoice_item, item: item5 , invoice: invoice4 , unit_price: 1.5)

      transaction1 = create(:transaction, invoice: invoice1, result: 0)
      transaction2 = create(:transaction, invoice: invoice1, result: 1)
      transaction3 = create(:transaction, invoice: invoice2, result: 0)
      transaction4 = create(:transaction, invoice: invoice3, result: 0)
      transaction5 = create(:transaction, invoice: invoice4, result: 1)

      #*** test summary ***#
      # merchant1 total revenue = 6
      # merchant2 total revenue = 1.5
      # merchant3 total revenue = 0
      


      get "/api/v1/merchants/most_revenue?quantity=1"
      expect(response).to be_successful
      merchants = JSON.parse(response.body)
      
      expect(merchants["data"].count).to eq(1)
      
      expect(merchants["data"][0]["type"]).to eq("merchant")
      expect(merchants["data"][0]["id"]).to eq(merchant1.id.to_s)
      expect(merchants["data"][0]["attributes"]["name"]).to eq(merchant1.name)
      
      get "/api/v1/merchants/most_revenue?quantity=3"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      
      expect(merchant["data"].count).to eq(3)

  
    end
  end
end