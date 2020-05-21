class SuppliersController < ApplicationController
  include SuppliersHelper

  before_action :authenticate_user!
  before_action :track_user!
  before_action :active_supplier!, only: [:edit, :update]
  before_action :constrain_destroy!, only: :destroy
  before_action :authorize_user!

  def new
    @supplier=Supplier.new
  end

  def create
    @supplier=Supplier.new(supplier_params)

    if @supplier.save
      save_supplier_create_event(supplier: @supplier, editor: current_user)
      flash[:success]='Поставщик создан'
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
    @old=Supplier.find(params[:id])

    if @supplier.update(supplier_params)
      save_supplier_edit_event(snap_from: @old, snap_to: @supplier, editor: current_user)
      flash[:success]="Поставщие обновлен"
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
    supplier=Supplier.find(params[:id])

    if supplier.active?
      flash[:success]="Поставщик удален"
      save_supplier_delete_event(supplier: supplier, editor: current_user)
    else
      flash[:success]="Поставщик восстановлен"
      save_supplier_restore_event(supplier: supplier, editor: current_user)
    end

    supplier.toggle!(:active)

    redirect_to root_path
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :phone, :address)
  end
end
