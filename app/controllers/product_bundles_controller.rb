class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def show
    @product_bundle = ProductBundle.find(params[:id])
  end

  def new
    @product_bundle = ProductBundle.new
    @product_types = ProductType.all
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_type_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)
    @product_bundle.save
    redirect_to @product_bundle
  end
end