class Ticket < ActiveRecord::Base
  named_scope :active_and_project_active, :include => :project, :conditions => ["projects.active = ? AND tickets.active = ? AND tickets.on_hold = ? AND tickets.invalid = ?", true, true, false, false], :order => "tickets.created_at DESC"

  named_scope :active, :conditions => {:active => true, :on_hold => false, :invalid => false}, :order => "created_at DESC"
  named_scope :closed, :conditions => {:active => false}, :order => "created_at DESC"
  named_scope :on_hold, :conditions => {:active => true, :on_hold => true}, :order => "created_at DESC"
  named_scope :invalid, :conditions => {:active => true, :invalid => true}, :order => "created_at DESC"
  named_scope :in_projects, lambda {|ids| {:conditions => ["project_id IN (?)", ids]}}

  belongs_to :project
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :change_logs, :dependent => :destroy

  validates_presence_of :project, :user
  validate_on_create :title_or_text

  def title_or_text
    return true unless self.details.nil? || self.details.empty?
    return true unless self.title.nil? || self.title.empty?
    self.errors.add("Ticket must have either title or details")
  end

  def mark_active
    self.update_attributes(:active => true, :invalid => false, :on_hold => false)
  end
  alias mark_open mark_active

  def mark_closed
    self.update_attributes(:active => false, :invalid => false, :on_hold => false)
  end

  def mark_invalid
    self.update_attributes(:invalid => true)
  end

  def mark_on_hold
    self.update_attributes(:on_hold => true)
  end

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

  def active?
    return false unless self.project.active?
    super
  end

  def active
    return false unless self.project.active?
    super
  end

end
