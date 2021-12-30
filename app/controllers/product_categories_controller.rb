class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end

  def show
    id = params[:id]
    @product_category = ProductCategory.find(id)
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    product_category_params = params.require(:product_category).permit(:name)

    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save()
      redirect_to root_path, notice:'Categoria cadastrada com sucesso'
    else
      flash.now[:alert] = 'Falha ao cadastrar Categoria'
      render 'new'
    end
  end

end