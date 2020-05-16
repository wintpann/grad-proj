module ApplicationHelper

  def track_user!
    current_user.update_attribute(:last_seen, Time.now) if logged_in?
  end
  
end
