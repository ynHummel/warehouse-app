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
    @suppliers = Supplier.all

    product_type_params = params.require(:product_type).permit(
      :name, :sku, :weight,
      :length, :height, :width, :supplier_id 
    )
    @product_type = ProductType.new(product_type_params)
    
    if @product_type.save()
      redirect_to product_type_path(@product_type.id), notice: 'Modelo de produto registrado com sucesso' 
    else
      flash.now[:alert] = 'Não foi possível gravar o Modelo de produto'
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @product_type = ProductType.find(id)
    @suppliers = Supplier.all
  end

  def update
    @suppliers = Supplier.all
    id = params[:id]

    product_type_params = params.require(:product_type).permit(
      :name, :weight, :length, :height, :width, :supplier_id 
    )

    @product_type = ProductType.find(id)
    if @product_type.update(product_type_params)
      redirect_to product_type_path(@product_type.id), notice:'Modelo de produto atualizado com sucesso' 
    else
      flash.now[:alert] = 'Não foi possível atualizar o modelo de produto'
      render 'edit'
    end

  end


end