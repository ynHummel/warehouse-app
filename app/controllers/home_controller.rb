class HomeController < ApplicationController
  def index
    render plain: "Bem vindo ao WareHouse App"
  end
end