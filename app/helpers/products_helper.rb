module ProductsHelper

  def active_product!
    if !Product.find(params[:id].to_i).active?
      flash[:danger]="Отказано. Сперва восстановите продукт"
      redirect_to root_path
    end
  end

  def authorize_user!
    case params[:action]
    when 'edit', 'update', 'new', 'create'
      if !current_user.can?('change_products')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'destroy'
      if !current_user.can?('active_products')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    end
  end

  def constrain_restore!
    product=Product.find(params[:id])
    if !product.active?
      if !product.supplier.active?
        flash[:danger]="Отказано. Сперва восстановите соответствующего поставщика"
        redirect_to root_path
      end
    end
  end

  def constrain_delete!
    product=Product.find(params[:id])
    if product.active?
      if !Warehouse.new_product?(product.id)
        flash[:danger]="Отказано. Этот продукт есть на складе"
        redirect_to root_path
      end
    end
  end

  def save_create_product_event(options={})
    head_event=HeadEvent.create(event_type: 'product_change', goal_type: 'product_create', editor_id: options[:editor].id, supplier_id: options[:product].supplier.id, product_id: options[:product].id)
    change_event=head_event.create_product_change_event(event_type: 'create')
    product_snap=ProductSnap.create_snap(options[:product])
    create_event=change_event.create_product_create_event(product_snap_id: product_snap.id, editor_id: options[:editor].id)
  end

  def save_product_edit_event(options={})
    head_event=HeadEvent.create(event_type: 'product_change', goal_type: 'product_edit', editor_id: options[:editor].id)
    change_event=head_event.create_product_change_event(event_type: 'edit')
    snap_from=ProductSnap.create_snap(options[:snap_from])
    snap_to=ProductSnap.create_snap(options[:snap_to])
    edit_event=change_event.create_product_edit_event(from_snap_id: snap_from.id, to_snap_id: snap_to.id, editor_id: options[:editor].id)
    head_event.update(supplier_id: snap_from.supplier_id, product_id: snap_from.product_id)
  end

  def save_product_delete_event(options={})
    head_event=HeadEvent.create(event_type: 'product_change', goal_type: 'product_delete', editor_id: options[:editor].id)
    change_event=head_event.create_product_change_event(event_type: 'delete')
    product_snap=ProductSnap.create_snap(options[:product])
    delete_event=change_event.create_product_delete_event(product_snap_id: product_snap.id, editor_id: options[:editor].id)
    head_event.update(supplier_id: product_snap.supplier_id, product_id: product_snap.product_id)
  end

  def save_product_restore_event(options={})
    head_event=HeadEvent.create(event_type: 'product_change', goal_type: 'product_restore', editor_id: options[:editor].id)
    change_event=head_event.create_product_change_event(event_type: 'restore')
    product_snap=ProductSnap.create_snap(options[:product])
    restore_event=change_event.create_product_restore_event(product_snap_id: product_snap.id, editor_id: options[:editor].id)
    head_event.update(supplier_id: product_snap.supplier_id, product_id: product_snap.product_id)
  end

end
