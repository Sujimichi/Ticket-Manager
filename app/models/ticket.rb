class Ticket < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :project

  def create
    project = self.project
    self.number = project.next_num
    super
  end

end
