module ApplicationHelper

  def track_user!
    current_user.update_attribute(:last_seen, Time.now) if logged_in?
  end

  def to_local_time(time)
    (time+3.hours).to_s[0..-4]
  end

  def rights
    [:set_rights, :invites,
     :change_self, :change_users, :active_users, :all_users,
     :change_suppliers, :active_suppliers,
     :change_products, :active_products,
     :warehouse, :arrival, :realization, :refund, :write_off, :events]
  end

  def event_types
    {'User created'=>'user_create','User updated'=>'user_edit', 'User deleted'=>'user_delete', 'User restored'=>'user_restore',
     'Supplier created'=>'supplier_create','Supplier updated'=>'supplier_edit', 'Supplier deleted'=>'supplier_delete', 'Supplier restored'=>'supplier_restore',
     'Product created'=>'product_create','Product updated'=>'product_edit', 'Product deleted'=>'product_delete', 'Product restored'=>'product_restore',
     'Arrival'=>'arrival', 'Refund'=>'refund', 'Write-off'=>'write_off', 'Realization'=>'realization'}
  end

  def sort_types
    {'Date (newest first)'=>'date_decs','Date (oldest first)'=>'date_asc','Sum (biggest first)'=>'sum_desc','Sum (smallest first)'=>'sum_asc'}
  end

  def get_links(model)
    links={}
    links[:left]=model.current_page-model.links_half
    links[:right]=model.current_page+model.links_half
    loop do
      if model.valid_page?(links[:left]) && model.valid_page?(links[:right])
        # everything is valid
        return links
      elsif model.valid_page?(links[:left]) && !model.valid_page?(links[:right]) && model.valid_page?(links[:left]-1)
        # right not valid, can move left
        links[:left]-=1
        links[:right]-=1
      elsif model.valid_page?(links[:right]) && !model.valid_page?(links[:left]) && model.valid_page?(links[:right]+1)
        # left not valid, can move right
        links[:left]+=1
        links[:right]+=1
      elsif model.valid_page?(links[:left]) && !model.valid_page?(links[:right]) && !model.valid_page?(links[:left]-1)
        # right not valid, cannot move left
        links[:right]-=1
      elsif model.valid_page?(links[:right]) && !model.valid_page?(links[:left]) && !model.valid_page?(links[:right]+1)
        # left not valid, cannot move right
        links[:left]+=1
      elsif !model.valid_page?(links[:right]) && !model.valid_page?(links[:left])
        # both not valid
        links[:left]+=1
        links[:right]-=1
      end
    end
  end

end
