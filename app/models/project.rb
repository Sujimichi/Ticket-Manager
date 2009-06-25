class Project < ActiveRecord::Base
  has_many :project_users
  has_many :projects, :through => :project_users

  has_many :tickets

  def next_num
    [0,self.tickets.map{|t| t.number}].flatten.compact.max + 1
  end
end
