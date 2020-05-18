class Api::V1::MerchantsController < Api::V1::BaseController
  def index   
    response = {data: []}
    Merchant.all.each do |merchant|
      data = {
        id: merchant.id,
        type: "merchant",
        attributes: {name: merchant.name}
      }
      response[:data] << data
    end

    render json: response
  end
end