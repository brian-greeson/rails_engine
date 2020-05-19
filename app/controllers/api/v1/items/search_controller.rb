class Api::V1::Items::SearchController < Api::V1::BaseController
  def show
    render json: ItemSerializer.new(Item.find_by(search_params))
  end

private
  def search_params
    params.permit(:id, :name, :unit_price, :description, :merchant_id, :created_at, :updated_at)
  end
end