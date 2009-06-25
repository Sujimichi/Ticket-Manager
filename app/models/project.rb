class Project < ActiveRecord::Base
  has_many :project_users
  has_many :projects, :through => :project_users

  has_many :tickets

  def next_num
    [0,self.tickets.map{|t| t.number}].flatten.compact.max + 1
  end


  def active_tickets
    self.tickets.find(:all, :conditions => {:active => true, :on_hold => false, :invalid => false})
  end

  def closed_tickets
    self.tickets.find(:all, :conditions => {:active => false})
  end

  def on_hold_tickets
    self.tickets.find(:all, :conditions => {:active => true, :on_hold => true})
  end

  def invalid_tickets
    self.tickets.find(:all, :conditions => {:active => true, :invalid => true})
  end

end
