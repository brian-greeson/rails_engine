class Api::V1::MerchantsController < Api::V1::BaseController
  def index   
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(merchant_params[:id]))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end
  
  def create
    begin
      render json: MerchantSerializer.new(Merchant.create!(merchant_params))
    rescue ActiveRecord::RecordInvalid
      render json: {data: nil}
    end
  end

  def update
    begin
      render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
    rescue ActiveRecord::RecordInvalid
      render json: {data: nil}
    end
  end

  def destroy
    begin
      merchant = Merchant.find(merchant_params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end
end