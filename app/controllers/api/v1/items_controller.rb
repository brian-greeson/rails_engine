class Api::V1::ItemsController < Api::V1::BaseController
  def index
    response = {data: []}
    Item.all.each do |item|
      data = item_details(item)
      response[:data] << data
    end
    render json: response
  end

  def show
    render json: {data: item_details(Item.find(item_params[:id]))}
  end

  private

  def item_params
    params.permit(:id)
  end

  def item_details(item)
    {
      type: "item",
      id: item.id,
      attributes: {
        name: item.name,
        description: item.description,
        unit_price: item.unit_price,
        merchant_id: item.merchant_id
      }
    }
  end
end