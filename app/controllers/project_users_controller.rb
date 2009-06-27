class ProjectUsersController < ApplicationController

  def user_request
    project = Project.find(params[:project_id])
    user = User.find(params[:user_id])
    if project && user
      if user.projects.include?(project) || user.requested_projects.include?(project)
        flash[:error] = "You are already on this project" if user.projects.include?(project) 
        flash[:error] = "You have already requested to join this project" if user.requested_projects.include?(project)
      else
        ProjectUser.create(:user_id => user.id, :requested_project_id => project.id)
        flash[:notice] = "Request Sent"       
      end
    else
      things = [("User" unless user), ("Project" unless project)].compat.and_join

      flash[:error] = "I was unable to find the requested #{things}"

    end
    redirect_to :back
  end

  def accept
    request = ProjectUser.find(params[:id])
    project = request.requested_project
    return not_allowed! unless project.users.include?(current_user)
    request.accept
    redirect_to :back
  end

  def reject
    request = ProjectUser.find(params[:id])
    return not_allowed! unless request.requested_project.users.include?(current_user)
    request.destroy
    redirect_to :back
  end

end
