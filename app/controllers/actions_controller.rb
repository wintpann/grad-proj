class ActionsController < ApplicationController
  include ActionsHelper
  before_action :authenticate_user!
  before_action :track_user!
  before_action :authorize_user!

  before_action do
    @warehouses=Warehouse.all
  end

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

    save_arrival(params: product_params(:arrival), editor: current_user)
    redirect_to root_path
  end

  def new_realization
    if @warehouses.empty?
      flash[:danger]="Nothing to sell"
      redirect_to root_path
    end
  end

  def create_realization
    if empty_products?(product_params(:realization))
      flash.now[:danger]="Empty realization"
      render 'new_realization'
      return
    end

    if Warehouse.more_than_is?(product_params(:realization))
      flash.now[:danger]="Can not sell more than have"
      render 'new_realization'
      return
    end

    save_realizatioin(params: product_params(:realization), editor: current_user)
    redirect_to root_path
  end

  def warehouse
  end

  def new_write_off
    if @warehouses.empty?
      flash[:danger]="Nothing to write-off"
      redirect_to root_path
    end
  end

  def create_write_off
    if empty_products?(product_params(:write_off))
      flash.now[:danger]="Empty write-off"
      render 'new_write_off'
      return
    end

    if Warehouse.more_than_is?(product_params(:write_off))
      flash.now[:danger]="Can not write-off more than have"
      render 'new_write_off'
      return
    end

    save_write_off(params: product_params(:write_off), editor: current_user)
    redirect_to root_path
  end

  def new_refund
    if @warehouses.empty?
      flash[:danger]="Nothing to refund"
      redirect_to root_path
    end
  end

  def create_refund
    if empty_products?(product_params(:refund))
      flash.now[:danger]="Empty refund"
      render 'new_refund'
      return
    end

    if Warehouse.more_than_is?(product_params(:refund))
      flash.now[:danger]="Can not refund more than have"
      render 'new_refund'
      return
    end

    save_refund(params: product_params(:refund), editor: current_user)
    redirect_to root_path
  end

  def events
    @all_events=HeadEvent.order(created_at: :desc)
    @all_events.paginate(params[:page])

    if HeadEvent.bad_page?
      redirect_to events_path(page: 1)
      return
    end

    @events=@all_events.paginate(params[:page])
  end

  def invites
    @invites=UserInvite.all
  end

  def new_invite
    @invite=UserInvite.create_invite
  end

  def get_rights
    @users=User.active
  end

  def set_rights
    User.find_by(identifier: params[:user]).update_rights(rights_params)
    flash[:success]='Done'
    redirect_to rights_path
  end

  def destroy_invite
    UserInvite.find(params[:id]).destroy
    redirect_to invites_path
  end

  private

  def product_params(type)
    params.require(type).permit(Product.params)
  end

  def rights_params
    params.require(params[:user]).permit(rights)
  end
end
