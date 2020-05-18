class Api::V1::MerchantsController < Api::V1::BaseController
  def index   
    response = {data: []}
    Merchant.all.each do |merchant|
      response[:data] << merchant_details(merchant)
    end
    render json: response
  end

  def show
    render json: {data: merchant_details( Merchant.find(merchant_params[:id]))}
  end

  private

  def merchant_params
    params.permit(:id)
  end

  def merchant_details(merchant)
    {
        type: "merchant",
        id: merchant.id.to_s,
        attributes: {name: merchant.name}
      }
  end
end