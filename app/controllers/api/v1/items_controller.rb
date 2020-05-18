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

  def destroy
    begin
      item = Item.find(item_params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    else
      render json: {data: item_details(item)}
    end
  end

  private

  def item_params
    params.permit(:id)
  end

  def item_details(item)
    {
      type: "item",
      id: item.id.to_s,
      attributes: {
        name: item.name,
        description: item.description,
        unit_price: item.unit_price.to_f,
        merchant_id: item.merchant_id
      }
    }
  end
end