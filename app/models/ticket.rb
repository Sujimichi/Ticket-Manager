class Ticket < ActiveRecord::Base
  named_scope :active, :conditions => {:active => true, :on_hold => false, :invalid => false}
  named_scope :closed, :conditions => {:active => false}
  named_scope :on_hold, :conditions => {:active => true, :on_hold => true}
  named_scope :invalid, :conditions => {:active => true, :invalid => true}


  belongs_to :project
  validates_presence_of :project


  def mark_closed
    self.update_attributes(:active => false)
  end

  def mark_invalid
    self.update_attributes(:invalid => true)
  end

  def mark_on_hold
    self.update_attributes(:on_hold => true)
  end

  def mark_active
    self.update_attributes(:active => true, :invalid => false, :on_hold => false)
  end
  alias mark_open mark_active


  def status
    return "on_hold" if self.on_hold?
    return "invalid" if self.invalid?
    return "active" if self.active?
    "closed"
  end

end
