class ProductionEvent < ApplicationRecord
  belongs_to :head_event

  has_many :arrival_events
  has_many :realization_events
  has_many :write_off_events
  has_many :refund_events

  def editor
    User.find(self.editor_id)
  end

  def update_sum(sum)
    self.update_attribute(:sum, self.sum+sum)
  end
end
