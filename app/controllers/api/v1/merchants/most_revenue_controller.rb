class Api::V1::Merchants::MostRevenueController < Api::V1::BaseController
  
  def index
    begin    
      render json: MerchantSerializer.new(Revenue.most(revenue_params))
    rescue
      render json: {data: nil}
    end
  end

private

  def revenue_params
    params.permit(:controller, :quantity)
  end
end