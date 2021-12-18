class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(
      :name, :code, :address, :state, :city,
      :postal_code, :description, :total_area,
      :useful_area
    )

    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      redirect_to warehouse_path(@warehouse.id), notice:'Galpão registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível salvar o galpão'
      render 'new'
    end
  end
end