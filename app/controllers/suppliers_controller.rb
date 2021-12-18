class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
  end

  def show
    id = params[:id]
    @supplier = Supplier.find(id)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(
      :trading_name, :company_name, :cnpj, 
      :address, :email, :telephone
    )

    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
      redirect_to supplier_path(@supplier.id), notice:'Fornecedor registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar o Fornecedor'
      render 'new'
    end
  end

end