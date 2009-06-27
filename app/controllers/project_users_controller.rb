class ProjectUsersController < ApplicationController

  def user_request
    project = Project.find(params[:project_id])
    user = User.find(params[:user_id])
    if project && user
      unless user.projects.include?(project)
        ProjectUser.create(:user_id => user.id, :requested_project_id => project.id)
        flash[:notice] = "Request Sent"
      else
        flash[:error] = "You are already on this project"
      end
    else
      things = [("User" unless user), ("Project" unless project)].compat.and_join

      flash[:error] = "I was unable to find the requested #{things}"

    end
    redirect_to :back
  end

end
