class HeadEvent < ApplicationRecord
  has_one :user_change_event
  has_one :supplier_change_event
  has_one :product_change_event
  has_one :production_event

  def self.filter_events(params)
    temp=self.all
    temp=temp.where('created_at >= ? and created_at <= ?', params[:date_from], params[:date_to].to_date+1.day)
  end
end
