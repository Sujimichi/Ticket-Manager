class WelcomeController < ApplicationController
  skip_before_filter :require_login


  def index
    if current_user
      @active_projects = current_user.projects.active
      @latest_tickets = current_user.tickets.active_and_project_active
    end
  end

end
