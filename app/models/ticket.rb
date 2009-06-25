class Ticket < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :project

  def create
    super
    project = self.project
    self.update_attributes(:number => project.next_num)
    self
  end

end
