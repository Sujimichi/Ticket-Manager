class ProjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def accept_request
    self.update_attributes(:project_id => self.requested_project_id, :requested_project_id => nil)
  end
end
