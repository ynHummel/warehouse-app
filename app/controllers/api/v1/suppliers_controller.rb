class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: suppliers.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    supplier = Supplier.find(params[:id])
    render json: supplier.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def create
    supplier_params = params.permit(
      :trading_name, :company_name, :cnpj, 
      :address, :email, :telephone
    )
    supplier = Supplier.new(supplier_params)
    if supplier.save
      render json: supplier.as_json(except: [:created_at, :updated_at]), status: 201
    else
      render json: supplier.errors.full_messages, status: 422
    end
  end

end