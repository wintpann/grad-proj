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
    {'Пользователь создан'=>'user_create','Пользователь обновлен'=>'user_edit', 'Пользователь удален'=>'user_delete', 'Пользователь восстановлен'=>'user_restore',
     'Поставщик создан'=>'supplier_create','Поставщик обновлен'=>'supplier_edit', 'Поставщик удален'=>'supplier_delete', 'Поставщик восстановлен'=>'supplier_restore',
     'Продукт создан'=>'product_create','Продукт обновлен'=>'product_edit', 'Продукт удален'=>'product_delete', 'Продукт восстановлен'=>'product_restore',
     'Поступление'=>'arrival', 'Возврат'=>'refund', 'Списание'=>'write_off', 'Реализация'=>'realization'}
  end

  def sort_types
    {'Дате (сперва новые)'=>'date_decs','Дате (сперва старые)'=>'date_asc','Сумме (сперва большие)'=>'sum_desc','Сумме (сперва малые)'=>'sum_asc'}
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
