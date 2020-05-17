class Api::V1::ItemsController < Api::V1::BaseController
  def index
    render json: {"data": Item.all}
  end
end