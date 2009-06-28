class WelcomeController < ApplicationController
  skip_before_filter :require_login


  def index
    if current_user
      @active_projects = current_user.projects.active
      @latest_tickets = current_user.tickets.active.find(:all, :order => "created_at DESC")
    end
  end

end
