module ActionsHelper

  def empty_products?(arrivals)
    arrivals.each { |item, amount| return false if amount.to_d>0 }
    return true
  end

  def save_arrival(options={})
    Warehouse.add_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation')
    production_event=head_event.create_production_event(event_type: 'arrival', editor_id: options[:editor].id)
    ArrivalEvent.create_arrival(params: options[:params], event: production_event)
  end

  def save_realizatioin(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation')
    production_event=head_event.create_production_event(event_type: 'realization', editor_id: options[:editor].id)
    RealizationEvent.create_realization(params: options[:params], event: production_event)
  end

  def save_write_off(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation')
    production_event=head_event.create_production_event(event_type: 'write_off', editor_id: options[:editor].id)
    WriteOffEvent.create_write_off(params: options[:params], event: production_event)
  end

  def save_refund(options={})
    Warehouse.remove_products(options[:params])
    head_event=HeadEvent.create(event_type: 'production_operation')
    production_event=head_event.create_production_event(event_type: 'refund', editor_id: options[:editor].id)
    RefundEvent.create_refund(params: options[:params], event: production_event)
  end
end
