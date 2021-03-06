class User < ActiveRecord::Base
  acts_as_authentic
  named_scope :user_project_associates, lambda {|id, ids| {:joins => :project_users, :conditions => ["project_users.project_id IN (?) AND NOT user_id = ?", ids, id]}}
  has_many :project_users
  has_many :projects, :through => :project_users, :include => :tickets

  has_many :tickets
  has_many :comments

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
    ids = self.project_users.map{|pu| pu.requested_project_id}.compact
    Project.find(ids)
  end

  def associates
    #return all users who are in projects self is part of, does not return self.
    #done of named scope to it is still a proxy (right word?)
    User.user_project_associates(self.id, self.projects.map{|p| p.id})
  end
end
