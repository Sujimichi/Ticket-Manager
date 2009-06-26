class Project < ActiveRecord::Base
  has_many :project_users
  has_many :projects, :through => :project_users

  has_many :tickets, :dependent => :destroy

  validates_presence_of :name

  def active_tickets
    self.tickets.active
  end

  def closed_tickets
    self.tickets.closed
  end

  def on_hold_tickets
    self.tickets.on_hold
  end

  def invalid_tickets
    self.tickets.invalid
  end

end
