class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    supplier_must_exists
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
    @products=Product.all
  end

  def destroy
    Product.find(params[:id]).toggle!(:active)
    flash[:success]="Done"
    redirect_to root_path
  end

  private

  def supplier_must_exists
    if !Supplier.any?
      flash[:danger]="At least one supplier must exist"
      redirect_to root_path
    end
  end

  def product_params
    params.require(:product).permit(:code, :name, :unit, :description, :price_in, :price_out)
  end
end
