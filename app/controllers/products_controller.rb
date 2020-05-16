class ProductsController < ApplicationController
  include ProductsHelper

  before_action :authenticate_user!
  before_action :track_user!
  before_action :active_product!, only: [:edit, :update]
  before_action :constrain_restore!, only: :destroy

  def new
    supplier_must_be_available
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)
    @product.supplier_id=params[:product][:supplier]
    if @product.save
      flash[:success]="Product created"
      redirect_to root_path
    else
      @errors=@product.errors.full_messages
      render 'new'
    end
  end

  def edit
    supplier_must_be_available
    @product=Product.find(params[:id])
  end

  def update
    @product=Product.find(params[:id])
    @product.supplier_id=params[:product][:supplier]
    if @product.update(product_params)
      flash[:success]="Product updated"
      redirect_to root_path
    else
      @errors=@product.errors.full_messages
      render 'edit'
    end
  end

  def show
    @product=Product.find(params[:id])
  end

  def index
    @products=Product.active
  end

  def inactive
    @products=Product.inactive
  end

  def destroy
    Product.find(params[:id]).toggle!(:active)
    flash[:success]="Done"
    redirect_to root_path
  end

  private

  def supplier_must_be_available
    if !Supplier.active.any?
      flash[:danger]="At least one supplier must exist and be active"
      redirect_to root_path
    end
  end

  def product_params
    params.require(:product).permit(:code, :name, :unit, :description, :price_in, :price_out)
  end
end
