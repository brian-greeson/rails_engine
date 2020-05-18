class Api::V1::ItemsController < Api::V1::BaseController
  def index
    response = {data: []}
    Item.all.each do |item|
      data = {
        id: item.id,
        type: "item",
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
      response[:data] << data
    end
    render json: response
  end
end