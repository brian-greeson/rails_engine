class Api::V1::MerchantsController < Api::V1::BaseController
  def index   
    response = {data: []}
    Merchant.all.each do |merchant|
      data = {
        type: "merchant",
        id: merchant.id,
        attributes: {name: merchant.name}
      }
      response[:data] << data
    end

    render json: response
  end
end