class Api::V1::ItemMerchantController < Api::V1::BaseController
  def index  
    begin
      item = Item.find(item_merchant_params[:item_id])
      render json: MerchantSerializer.new(item.merchant)
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

  private
  def item_merchant_params
    params.permit(:item_id)
  end
end