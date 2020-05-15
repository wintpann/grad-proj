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
    if empty_arrival?(arrival_params)
      flash[:danger]='Empty arrival'
      @products=Product.active
      render 'new_arrival'
      return
    end

    Warehouse.add_products(arrival_params)
    redirect_to root_path
  end

  def arrival_params
    params.require(:arrival).permit(Product.params)
  end
end
