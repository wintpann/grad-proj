class ActionsController < ApplicationController
  include ActionsHelper
  before_action :authenticate_user!

  def new_arrival
    if !Product.any?
      flash[:danger]='No products to arrive'
      redirect_to root_path
    end
    @products=Product.active
  end

  def create_arrival
    if empty_arrival?(product_params(:arrival))
      flash.now[:danger]='Empty arrival'
      @products=Product.active
      render 'new_arrival'
      return
    end

    Warehouse.add_products(product_params(:arrival))
    redirect_to root_path
  end

  def new_realization
    @warehouses=Warehouse.all

    if @warehouses.empty?
      flash[:danger]="Nothing to sell"
      redirect_to root_path
    end
  end

  def create_realization
    if Warehouse.more_than_is?(product_params(:realization))
      flash.now[:danger]="Can not sell more than have"
      @warehouses=Warehouse.all
      render 'new_realization'
      return
    end

    Warehouse.remove_products(product_params(:realization))
    redirect_to root_path
  end

  def product_params(type)
    params.require(type).permit(Product.params)
  end
end
