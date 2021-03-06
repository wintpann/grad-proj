class ProductsController < ApplicationController
  include ProductsHelper

  before_action :authenticate_user!
  before_action :track_user!
  before_action :active_product!, only: [:edit, :update]
  before_action :constrain_restore!, only: :destroy
  before_action :constrain_delete!, only: :destroy
  before_action :authorize_user!

  def new
    supplier_must_be_available
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)
    @product.supplier_id=params[:product][:supplier]
    if @product.save
      save_create_product_event(product: @product, editor: current_user)
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

    @old=Product.find(params[:id])
    if @product.update(product_params)
      save_product_edit_event(snap_from: @old, snap_to: @product, editor: current_user)
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
    if params[:search] && !params[:search][:string].empty?
      if params[:search][:in]=='name'
        @products=@products.where("lower(name) like ?", "%" + params[:search][:string].downcase + "%")
      elsif params[:search][:in]=='description'
        @products=@products.where("lower(description) like ?", "%" + params[:search][:string].downcase + "%")
      end
    end
  end

  def inactive
    @products=Product.inactive
  end

  def destroy
    product=Product.find(params[:id])

    if product.active?
      flash[:success]="Product deleted"
      save_product_delete_event(product: product, editor: current_user)
    else
      flash[:success]="Product restored"
      save_product_restore_event(product: product, editor: current_user)
    end

    product.toggle!(:active)

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
