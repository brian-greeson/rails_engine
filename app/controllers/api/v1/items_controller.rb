class Api::V1::ItemsController < Api::V1::BaseController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(item_params[:id]))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

  def destroy
    begin
      item = Item.find(item_params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    else
      render json: ItemSerializer.new(item)
    end
  end

  private

  def item_params
    params.permit(:id)
  end
end