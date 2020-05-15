class SuppliersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @supplier=Supplier.new
  end

  def create
    @supplier=Supplier.new(supplier_params)

    if @supplier.save
      flash[:success]='Supplier created'
      redirect_to supplier_path(@supplier)
    else
      @errors=@supplier.errors.full_messages
      render 'new'
    end

  end

  def edit
    @supplier=Supplier.find(params[:id])
  end

  def update

    @supplier=Supplier.find(params[:id])

    if @supplier.update(supplier_params)
      flash[:success]="Supplier updated"
      redirect_to supplier_path(@supplier)
    else
      @errors=@supplier.errors.full_messages
      render 'edit'
    end

  end

  def index
    @suppliers=Supplier.active
  end

  def inactive
    @suppliers=Supplier.inactive
  end

  def show
    @supplier=Supplier.find(params[:id])
  end

  def destroy
    Supplier.find(params[:id]).toggle!(:active)
    flash[:success]="Done"
    redirect_to root_path
  end

  def supplier_params
    params.require(:supplier).permit(:name, :phone, :address)
  end
end
