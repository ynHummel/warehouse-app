class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    @warehouse = Warehouse.find(id = params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save()
      redirect_to warehouse_path(@warehouse.id), notice:'Galpão registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível salvar o galpão'
      render 'new'
    end
  end

  def edit
    @warehouse = Warehouse.find(id = params[:id])
  end

  def update
    @warehouse = Warehouse.find(id = params[:id])

    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice:'Galpão atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível salvar o galpão'
      render 'edit'
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(
      :name, :code, :address, :state, :city,
      :postal_code, :description, :total_area,
      :useful_area
    )
  end
  
end