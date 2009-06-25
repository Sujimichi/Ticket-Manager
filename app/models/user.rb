class User < ActiveRecord::Base
  acts_as_authentic

  has_many :project_users
  has_many :projects, :through => :project_users, :include => :tickets

  def tickets
    Ticket.find(:all, :conditions => ["project_id IN (?)", self.projects.map{|p| p.id}])
  end
end
