class ProjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def accept_request
    self.update_attributes(:project_id => self.requested_project_id, :requested_project_id => nil)
  end
  alias accept accept_request

  def reject_request
    self.destroy
  end
  alias reject reject_request


  def requested_project
    Project.find(self.requested_project_id)
  end
end
