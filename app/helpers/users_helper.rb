module UsersHelper

  def correct_user!
    if params[:id].to_i!=current_user.id
      flash[:danger]="Access denied"
      redirect_to root_path
    end
  end

  def active_user!
    if !User.find(params[:id].to_i).active?
      flash[:danger]="Denied. Restore user first"
      redirect_to root_path
    end
  end
  
end
