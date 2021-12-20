class ProductTypesController < ApplicationController
  def show
    id = params[:id]
    @product_type = ProductType.find(id)
  end
  
  def new
   @product_type = ProductType.new
   @suppliers = Supplier.all
  end

  def create
    product_type_params = params.require(:product_type).permit(
      :name, :sku, :weight,
      :length, :height, :width, :supplier_id 
    )
    product_type = ProductType.new(product_type_params)
    if product_type.save
      redirect_to product_type_path(product_type.id), notice: 'Modelo de produto registrado com sucesso' 
    end
  end
end