class User < ActiveRecord::Base
  acts_as_authentic

  has_many :project_users
  has_many :projects, :through => :project_users, :include => :tickets

  has_many :tickets

  #all tickets from all user's projects
  def tickets 
    Ticket.in_projects(self.projects.map{|p| p.id})
  end

  #all comments from all user's tickets from all user's projects
  def comments
    Comment.in_tickets(self.tickets.map{|t| t.id})
  end

  def active_projects
    self.projects.active
  end

  def request_project project
    ProjectUser.create(:user_id => self.id, :requested_project_id => project.id)
  end

  def requested_projects
    self.project_users.find(:all, :conditions => {:project_id => nil})
  end
end
