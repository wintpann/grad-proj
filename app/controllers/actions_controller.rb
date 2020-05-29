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
      respond_to do |format|
        format.html { render 'events/details/production/arrival' }
        format.pdf { render pdf: "Arrival from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/production/arrival.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'refund'
      @event=event.production_event
      respond_to do |format|
        format.html { render 'events/details/production/refund' }
        format.pdf { render pdf: "Refund from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/production/refund.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'realization'
      @event=event.production_event
      respond_to do |format|
        format.html { render 'events/details/production/realization' }
        format.pdf { render pdf: "Realization from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/production/realization.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'write_off'
      @event=event.production_event
      respond_to do |format|
        format.html { render 'events/details/production/write_off' }
        format.pdf { render pdf: "Write off from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/production/write_off.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'product_edit'
      @event=event.product_change_event.product_edit_event
      respond_to do |format|
        format.html { render 'events/details/product/edit' }
        format.pdf { render pdf: "Product edit from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/product/edit.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'product_restore'
      @event=event.product_change_event.product_restore_event
      respond_to do |format|
        format.html { render 'events/details/product/restore' }
        format.pdf { render pdf: "Product restore from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/product/restore.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'product_delete'
      @event=event.product_change_event.product_delete_event
      respond_to do |format|
        format.html { render 'events/details/product/delete' }
        format.pdf { render pdf: "Product delete from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/product/delete.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'product_create'
      @event=event.product_change_event.product_create_event
      respond_to do |format|
        format.html { render 'events/details/product/create' }
        format.pdf { render pdf: "Product create from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/product/create.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'user_edit'
      @event=event.user_change_event.user_edit_event
      respond_to do |format|
        format.html { render 'events/details/user/edit' }
        format.pdf { render pdf: "User edit from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/user/edit.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'user_restore'
      @event=event.user_change_event.user_restore_event
      respond_to do |format|
        format.html { render 'events/details/user/restore' }
        format.pdf { render pdf: "User restore from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/user/restore.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'user_delete'
      @event=event.user_change_event.user_delete_event
      respond_to do |format|
        format.html { render 'events/details/user/delete' }
        format.pdf { render pdf: "User delete from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/user/delete.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'user_create'
      @event=event.user_change_event.user_create_event
      respond_to do |format|
        format.html { render 'events/details/user/create' }
        format.pdf { render pdf: "User create from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/user/create.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'supplier_edit'
      @event=event.supplier_change_event.supplier_edit_event
      respond_to do |format|
        format.html { render 'events/details/supplier/edit' }
        format.pdf { render pdf: "Supplier edit from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/supplier/edit.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'supplier_restore'
      @event=event.supplier_change_event.supplier_restore_event
      respond_to do |format|
        format.html { render 'events/details/supplier/restore' }
        format.pdf { render pdf: "Supplier restore from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/supplier/restore.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'supplier_delete'
      @event=event.supplier_change_event.supplier_delete_event
      respond_to do |format|
        format.html { render 'events/details/supplier/delete' }
        format.pdf { render pdf: "Supplier delete from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/supplier/delete.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    when 'supplier_create'
      @event=event.supplier_change_event.supplier_create_event
      respond_to do |format|
        format.html { render 'events/details/supplier/create' }
        format.pdf { render pdf: "Supplier create from #{to_local_time(@event.created_at)}", page_size: 'A4', template: "events/details/supplier/create.html.erb", layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
      end
    end
  end

  def new_arrival
    if !Product.active.any?
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
    @all_events=HeadEvent.all
    @all_events.paginate(params[:page])
    filter=params[:filter]

    if @all_events.empty?
      flash[:danger]="You don't have any events"
      redirect_to root_path
      return
    end

    if HeadEvent.bad_page? || !params[:filter] || params[:filter][:date_from].empty? || params[:filter][:date_to].empty?
      redirect_to events_path(page: 1, filter:{type: 'all', supplier: 'all', product: 'all', editor: 'all', date_from: HeadEvent.first.created_at.strftime('%Y-%m-%d'), date_to: HeadEvent.last.created_at.strftime('%Y-%m-%d'), sort: 'date_desc'})
      return
    end

    @all_events=@all_events.filter_events(filter)
    @events=@all_events.paginate(params[:page])

    respond_to do |format|
      format.html { render 'actions/events' }
      format.pdf { render pdf: "Events from #{params[:filter][:date_from]} to #{params[:filter][:date_to]}", page_size: 'A4', template: 'actions/events_pdf.html.erb', layout: "pdf.html", orientation: "Landscape", lowquality: true, zoom: 1, dpi: 75 }
    end
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

  def filter_params
    params.require(:filter).permit(:date_from, :date_to, :type, :supplier, :product, :editor, :sort)
  end
end
