module ApplicationHelper

  def track_user!
    current_user.update_attribute(:last_seen, Time.now) if logged_in?
  end

  def to_local_time(time)
    (time+3.hours).to_s[0..-4]
  end

end
