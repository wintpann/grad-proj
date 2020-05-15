module ActionsHelper

  def empty_products?(arrivals)
    arrivals.each { |item, amount| return false if amount.to_i>0 }
    return true
  end
end
