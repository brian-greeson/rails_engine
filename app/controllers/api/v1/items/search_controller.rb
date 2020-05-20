class Api::V1::Items::SearchController < Api::V1::BaseController

  def index
    begin
      render json: ItemSerializer.new(Item.find_matches(search_params))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find_match(search_params))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

private
  def search_params
    params.permit(:id, :name, :unit_price, :description, :merchant_id, :created_at, :updated_at)
  end
end