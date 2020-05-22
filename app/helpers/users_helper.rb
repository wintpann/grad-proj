module UsersHelper

  def correct_user!
    if params[:id].to_i!=current_user.id
      flash[:danger]="В доступе отказано"
      redirect_to root_path
    end
  end

  def active_user!
    if !User.find(params[:id].to_i).active?
      flash[:danger]="Отказано. Сперва восстановите пользователя"
      redirect_to root_path
    end
  end

  def authorize_user!
    case params[:action]
    when 'edit', 'update'
      if params[:id]!=current_user.id.to_s
        if !current_user.can?('change_users')
          flash[:danger]="В доступе отказано"
          redirect_to root_path
        end
      else
        if !current_user.can?('change_self')
          flash[:danger]="В доступе отказано"
          redirect_to root_path
        end
      end
    when 'destroy'
      if !current_user.can?('active_users')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'index', 'inactive'
      if !current_user.can?('all_users')
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    when 'show'
      if !current_user.can?('all_users') && params[:id]!=current_user.id.to_s
        flash[:danger]="В доступе отказано"
        redirect_to root_path
      end
    end
  end


  def save_user_create_event(options={})
    head_event=HeadEvent.create(event_type: 'user_change', goal_type: 'user_create')
    change_event=head_event.create_user_change_event(event_type: 'create')
    user_snap=UserSnap.create_snap(options[:user])
    create_event=change_event.create_user_create_event(user_snap_id: user_snap.id)
  end

  def save_user_edit_event(options={})
    head_event=HeadEvent.create(event_type: 'user_change', goal_type: 'user_edit', editor_id: options[:editor].id)
    change_event=head_event.create_user_change_event(event_type: 'edit')
    snap_from=UserSnap.create_snap(options[:user_from])
    snap_to=UserSnap.create_snap(options[:user_to])
    edit_event=change_event.create_user_edit_event(from_snap_id: snap_from.id, to_snap_id: snap_to.id, editor_id: options[:editor].id)
  end

  def save_user_delete_event(options={})
    head_event=HeadEvent.create(event_type: 'user_change', goal_type: 'user_delete', editor_id: options[:editor].id)
    change_event=head_event.create_user_change_event(event_type: 'delete')
    user_snap=UserSnap.create_snap(options[:user])
    delete_event=change_event.create_user_delete_event(user_snap_id: user_snap.id, editor_id: options[:editor].id)
  end

  def save_user_restore_event(options={})
    head_event=HeadEvent.create(event_type: 'user_change', goal_type: 'user_restore', editor_id: options[:editor].id)
    change_event=head_event.create_user_change_event(event_type: 'restore')
    user_snap=UserSnap.create_snap(options[:user])
    restore_event=change_event.create_user_restore_event(user_snap_id: user_snap.id, editor_id: options[:editor].id)
  end

end
