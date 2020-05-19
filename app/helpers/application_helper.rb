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

end
