class Api::V1::Merchants::SearchController < Api::V1::BaseController
  
  def index
    begin
      render json: MerchantSerializer.new(Merchant.find_matches(search_params))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find_match(search_params))
    rescue ActiveRecord::RecordNotFound
      render json: {data: nil}
    end
  end

private
  def search_params
    params.permit(:id, :name)
  end
end