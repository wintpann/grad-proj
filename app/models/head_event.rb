class HeadEvent < ApplicationRecord
  has_one :user_change_event
  has_one :supplier_change_event
  has_one :product_change_event
  has_one :production_event

  def self.filter_events(params)
    temp=self.all
    temp=temp.where('created_at >= ? and created_at <= ?', params[:date_from], params[:date_to].to_date+1.day)

    if params[:type]!='all'
      if params[:type]=='production'
        temp=temp.where(event_type: 'production_operation')
      else
        temp=temp.where(goal_type: params[:type])
      end
    end

    if params[:supplier]!='all'
      temp=temp.where(supplier_id: params[:supplier])
    end

    if params[:product]!='all'
      temp=temp.where(product_id: params[:product])
    end

    if params[:editor]!='all'
      temp=temp.where(editor_id: params[:editor])
    end

    case params[:sort]
    when 'date_asc'
      temp=temp.order(created_at: :asc)
    when 'date_desc'
      temp=temp.order(created_at: :desc)
    when 'sum_asc'
      temp=temp.order(sum: :asc)
    when 'sum_desc'
      temp=temp.order(sum: :desc)
    end

    return temp
  end

  def editor
    User.find(editor_id)
  end

  def update_sum(sum)
    self.update_attribute(:sum, self.sum+sum)
  end
end
