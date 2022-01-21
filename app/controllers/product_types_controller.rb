class ProductTypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    @product_type = ProductType.find(params[:id])
    @items = @product_type.warehouse_items.group(:warehouse).count
  end

  def new
    @product_type = ProductType.new
    @suppliers = Supplier.all
    @product_categories = ProductCategory.all
  end

  def create
    @suppliers = Supplier.all
    @product_categories = ProductCategory.all
    @product_type = ProductType.new(product_type_params)

    if @product_type.save()
      redirect_to product_type_path(@product_type.id), notice: 'Modelo de produto registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível gravar o Modelo de produto'
      render 'new'
    end
  end

  def edit
    @product_type = ProductType.find(params[:id])
    @suppliers = Supplier.all
    @product_categories = ProductCategory.all
  end

  def update
    @suppliers = Supplier.all
    @product_categories = ProductCategory.all
    @product_type = ProductType.find(params[:id])

    if @product_type.update(product_type_params)
      redirect_to product_type_path(@product_type.id), notice: 'Modelo de produto atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar o modelo de produto'
      render 'edit'
    end
  end

  private

  def product_type_params
    params.require(:product_type).permit(
      :name, :weight, :length, :height, :width, :supplier_id, :product_category_id
    )
  end
end
