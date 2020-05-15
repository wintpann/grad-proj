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
    if empty_products?(product_params(:arrival))
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
    if empty_products?(product_params(:realization))
      flash.now[:danger]="Empty realization"
      @warehouses=Warehouse.all
      render 'new_realization'
      return
    end

    if Warehouse.more_than_is?(product_params(:realization))
      flash.now[:danger]="Can not sell more than have"
      @warehouses=Warehouse.all
      render 'new_realization'
      return
    end

    Warehouse.remove_products(product_params(:realization))
    redirect_to root_path
  end

  def warehouse
    @warehouses=Warehouse.all
  end

  def new_write_off
    @warehouses=Warehouse.all

    if @warehouses.empty?
      flash[:danger]="Nothing to write-off"
      redirect_to root_path
    end
  end

  def create_write_off
    if empty_products?(product_params(:write_off))
      flash.now[:danger]="Empty write-off"
      @warehouses=Warehouse.all
      render 'new_write_off'
      return
    end

    if Warehouse.more_than_is?(product_params(:write_off))
      flash.now[:danger]="Can not write-off more than have"
      @warehouses=Warehouse.all
      render 'new_write_off'
      return
    end

    Warehouse.remove_products(product_params(:write_off))
    redirect_to root_path
  end

  def product_params(type)
    params.require(type).permit(Product.params)
  end
end
