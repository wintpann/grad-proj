class ActionsController < ApplicationController
  include ActionsHelper
  before_action :authenticate_user!
  before_action :track_user!
  before_action :authorize_user!

  before_action do
    @warehouses=Warehouse.all
  end

  def details
     event=HeadEvent.find(params[:id])
     case event.goal_type
     when 'arrival'
       @event=event.production_event
       render 'events/details/production/arrival'
     when 'refund'
       @event=event.production_event
       render 'events/details/production/refund'
     when 'realization'
       @event=event.production_event
       render 'events/details/production/realization'
     when 'write_off'
       @event=event.production_event
       render 'events/details/production/write_off'
     when 'product_edit'
       @event=event.product_change_event.product_edit_event
       render 'events/details/product/edit'
     when 'product_restore'
       @event=event.product_change_event.product_restore_event
       render 'events/details/product/restore'
     when 'product_delete'
       @event=event.product_change_event.product_delete_event
       render 'events/details/product/delete'
     when 'product_create'
       @event=event.product_change_event.product_create_event
       render 'events/details/product/create'
     when 'user_edit'
       @event=event.user_change_event.user_edit_event
       render 'events/details/user/edit'
     when 'user_restore'
       @event=event.user_change_event.user_restore_event
       render 'events/details/user/restore'
     when 'user_delete'
       @event=event.user_change_event.user_delete_event
       render 'events/details/user/delete'
     when 'user_create'
       @event=event.user_change_event.user_create_event
       render 'events/details/user/create'
     when 'supplier_edit'
       @event=event.supplier_change_event.supplier_edit_event
       render 'events/details/supplier/edit'
     when 'supplier_restore'
       @event=event.supplier_change_event.supplier_restore_event
       render 'events/details/supplier/restore'
     when 'supplier_delete'
       @event=event.supplier_change_event.supplier_delete_event
       render 'events/details/supplier/delete'
     when 'supplier_create'
       @event=event.supplier_change_event.supplier_create_event
       render 'events/details/supplier/create'
     end
   end

  def new_arrival
    if !Product.active.any?
      flash[:danger]='Нет продуктов для поступления'
      redirect_to root_path
    end
    @products=Product.active
  end

  def create_arrival
    if empty_products?(product_params(:arrival))
      flash.now[:danger]='Пустое поступление'
      @products=Product.active
      render 'new_arrival'
      return
    end

    save_arrival(params: product_params(:arrival), editor: current_user)
    redirect_to root_path
  end

  def new_realization
    if @warehouses.empty?
      flash[:danger]="Нечего продавать"
      redirect_to root_path
    end
  end

  def create_realization
    if empty_products?(product_params(:realization))
      flash.now[:danger]="Пустая реализация"
      render 'new_realization'
      return
    end

    if Warehouse.more_than_is?(product_params(:realization))
      flash.now[:danger]="Нельзя продать больше чем есть на складе"
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
      flash[:danger]="Нечего списывать"
      redirect_to root_path
    end
  end

  def create_write_off
    if empty_products?(product_params(:write_off))
      flash.now[:danger]="Пустое списание"
      render 'new_write_off'
      return
    end

    if Warehouse.more_than_is?(product_params(:write_off))
      flash.now[:danger]="Нельзя списать больше чем есть на складе"
      render 'new_write_off'
      return
    end

    save_write_off(params: product_params(:write_off), editor: current_user)
    redirect_to root_path
  end

  def new_refund
    if @warehouses.empty?
      flash[:danger]="Нечего возвращать"
      redirect_to root_path
    end
  end

  def create_refund
    if empty_products?(product_params(:refund))
      flash.now[:danger]="Пустой возврат"
      render 'new_refund'
      return
    end

    if Warehouse.more_than_is?(product_params(:refund))
      flash.now[:danger]="Нельзя вернуть больше чем есть на складе"
      render 'new_refund'
      return
    end

    save_refund(params: product_params(:refund), editor: current_user)
    redirect_to root_path
  end

  def events
    @all_events=HeadEvent.all
    @all_events.paginate(params[:page])
    filter=params[:filter]

    if @all_events.empty?
      flash[:danger]="Пока нет никаких событий"
      redirect_to root_path
      return
    end

    if HeadEvent.bad_page? || !params[:filter] || params[:filter][:date_from].empty? || params[:filter][:date_to].empty?
      redirect_to events_path(page: 1, filter:{type: 'all', supplier: 'all', product: 'all', editor: 'all', date_from: HeadEvent.first.created_at.strftime('%Y-%m-%d'), date_to: HeadEvent.last.created_at.strftime('%Y-%m-%d'), sort: 'date_desc'})
      return
    end

    @all_events=@all_events.filter_events(filter)
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
    flash[:success]='Права изменены'
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

  def filter_params
    params.require(:filter).permit(:date_from, :date_to, :type, :supplier, :product, :editor, :sort)
  end
end
