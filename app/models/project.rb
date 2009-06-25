class Project < ActiveRecord::Base
  has_many :project_users
  has_many :projects, :through => :project_users

  has_many :tickets

  def next_num
    self.tickets.map{|t| t.number}.max
  end
end
