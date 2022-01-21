class Api::V1::ProductTypesController < Api::V1::ApiController
  def index
    product_types = ProductType.all
    render json: product_types.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
    product_type = ProductType.find(params[:id])
    render json: product_type.as_json(
      except: [:created_at, :updated_at],
      methods: [:dimensions],
      include: { supplier: { except: [:created_at, :updated_at, :cnpj] } }
    ), status: 200
  end

  def create
    product_type_params = params.permit(
      :name, :weight, :length, :height,
      :width, :supplier_id, :product_category_id
    )
    pt = ProductType.new(product_type_params)
    if pt.save()
      render json: pt.as_json(except: [:created_at, :updated_at]), status: 201
    else
      render json: pt.errors.full_messages, status: 422
    end
  end
end
