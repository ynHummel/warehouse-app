class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    @warehouses = Warehouse.all
  end

  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :postal_code, :address, :city, :state, :total_area,
                                     :useful_area)
    w = Warehouse.new(warehouse_params)
    if w.save
      render json: w, status: 201
    else
      render json: w.errors.full_messages, status: 422
    end
  end
end
