class Api::V1::ProductTypesController < Api::V1::ApiController
  def index
    product_types = ProductType.all
    render json: product_types.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    begin
      product_type = ProductType.find(params[:id])
      render json: product_type.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404      
    end
  end
end