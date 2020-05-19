module SuppliersHelper

  def active_supplier!
    if !Supplier.find(params[:id].to_i).active?
      flash[:danger]="Denied. Restore supplier first"
      redirect_to root_path
    end
  end

  def constrain_destroy!
    supplier=Supplier.find(params[:id])
    if supplier.active?
      if supplier.products.active.any?
        flash[:danger]="Denied. Supplier is attached to < #{supplier.products.active.codes.join(', ')} >"
        redirect_to root_path
      end
    end
  end

  def authorize_user!
    case params[:action]
    when 'edit', 'update'
      if !current_user.can?('change_suppliers')
        flash[:danger]="You don't have right"
        redirect_to root_path
      end
    when 'destroy'
      if !current_user.can?('active_suppliers')
        flash[:danger]="You don't have right"
        redirect_to root_path
      end
    end
  end

  def save_supplier_create_event(options={})
    head_event=HeadEvent.create(event_type: 'supplier_change')
    change_event=head_event.create_supplier_change_event(event_type: 'create')
    supplier_snap=SupplierSnap.create_snap(options[:supplier])
    create_event=change_event.create_supplier_create_event(supplier_snap_id: supplier_snap.id, editor_id: options[:editor].id)
  end

  def save_supplier_edit_event(options={})
    head_event=HeadEvent.create(event_type: 'supplier_change')
    change_event=head_event.create_supplier_change_event(event_type: 'edit')
    snap_from=SupplierSnap.create_snap(options[:snap_from])
    snap_to=SupplierSnap.create_snap(options[:snap_to])
    edit_event=change_event.create_supplier_edit_event(from_snap_id: snap_from.id, to_snap_id: snap_to.id, editor_id: options[:editor].id)
  end

  def save_supplier_delete_event(options={})
    head_event=HeadEvent.create(event_type: 'supplier_change')
    change_event=head_event.create_supplier_change_event(event_type: 'delete')
    supplier_snap=SupplierSnap.create_snap(options[:supplier])
    delete_event=change_event.create_supplier_delete_event(supplier_snap_id: supplier_snap.id, editor_id: options[:editor].id)
  end

  def save_supplier_restore_event(options={})
    head_event=HeadEvent.create(event_type: 'supplier_change')
    change_event=head_event.create_supplier_change_event(event_type: 'restore')
    supplier_snap=SupplierSnap.create_snap(options[:supplier])
    restore_event=change_event.create_supplier_restore_event(supplier_snap_id: supplier_snap.id, editor_id: options[:editor].id)
  end

end
