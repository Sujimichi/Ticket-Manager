class Ticket < ActiveRecord::Base
  named_scope :active, :conditions => {:active => true, :on_hold => false, :invalid => false}
  named_scope :closed, :conditions => {:active => false}
  named_scope :on_hold, :conditions => {:active => true, :on_hold => true}
  named_scope :invalid, :conditions => {:active => true, :invalid => true}


  belongs_to :project
  validates_presence_of :project

  validate_on_create :title_or_text

  def title_or_text
    return true unless self.details.nil? || self.details.empty?
    return true unless self.title.nil? || self.title.empty?
    self.errors.add("Ticket must have either title or details")
  end


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
    return "on hold" if self.on_hold?
    return "invalid" if self.invalid?
    return "active" if self.active?
    "closed"
  end

  def priority
    return "Normal" if high_priority.nil?
    return "High" if high_priority
    return "Low" unless high_priority
  end

end
