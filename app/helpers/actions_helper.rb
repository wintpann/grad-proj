module ActionsHelper

  def empty_arrival?(arrivals)
    arrivals.each { |item, amount| return false if amount.to_i>0 }
    return true
  end
end
