class Api::V1::MerchantItemsController < Api::V1::BaseController
  def index   
    begin
      merchant = Merchant.find(merchant_item_params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    rescue ActiveRecord::RecordInvalid
      render json: {data: nil}
    end
  end

  private
  def merchant_item_params
    params.permit(:merchant_id)
  end
end