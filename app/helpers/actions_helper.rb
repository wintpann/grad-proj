module ActionsHelper

  def empty_products?(arrivals)
    arrivals.each { |item, amount| return false if amount.to_d>0 }
    return true
  end

  def authorize_user!
    case params[:action]
    when 'invites', 'new_invite', 'destroy_invite'
      if !current_user.can?('invites')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'warehouse'
      if !current_user.can?('warehouse')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'new_arrival', 'create_arrival'
      if !current_user.can?('arrival')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'new_realization', 'create_realization'
      if !current_user.can?('realization')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'new_refund', 'create_refund'
      if !current_user.can?('refund')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'new_write_off', 'create_write_off'
      if !current_user.can?('write_off')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'events'
      if !current_user.can?('events')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'set_rights', 'get_rights'
      if !current_user.can?('set_rights')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    end
  end

  def save_arrival(options={})
    Warehouse.add_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation', goal_type: 'arrival', editor_id: options[:editor].id)
    production_event=head_event.create_production_event(event_type: 'arrival', editor_id: options[:editor].id)
    ArrivalEvent.create_arrival(params: options[:params], event: production_event)
  end

  def save_realizatioin(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation', goal_type: 'realization', editor_id: options[:editor].id)
    production_event=head_event.create_production_event(event_type: 'realization', editor_id: options[:editor].id)
    RealizationEvent.create_realization(params: options[:params], event: production_event)
  end

  def save_write_off(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation', goal_type: 'write_off', editor_id: options[:editor].id)
    production_event=head_event.create_production_event(event_type: 'write_off', editor_id: options[:editor].id)
    WriteOffEvent.create_write_off(params: options[:params], event: production_event)
  end

  def save_refund(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation', goal_type: 'refund', editor_id: options[:editor].id)
    production_event=head_event.create_production_event(event_type: 'refund', editor_id: options[:editor].id)
    RefundEvent.create_refund(params: options[:params], event: production_event)
  end
end
