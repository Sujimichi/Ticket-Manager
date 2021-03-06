class ProjectsController < ApplicationController
  before_filter :assign_project, :only => [:show, :edit, :update, :destroy]

  def index
    @active_projects = current_user.active_projects
    @other_projects = current_user.projects - current_user.active_projects
  end

  def show
  end

  def new
    @project = Project.new
  end


  def edit
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      current_user.projects << @project
      flash[:notice] = 'Project was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  def update
    params[:project] ||= {}
    params[:project].merge!(:active => !@project.active) if params[:toggle]
    
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project was successfully updated.' unless request.xhr?
      return render :partial => 'projects/show_widget', :locals => {:project => @project} if request.xhr?
      redirect_to(@project)
    else
      render :action => "edit"
    end
  end

  def destroy
    name = @project.name
    @project.destroy
    flash[:notice] = "#{name} and its tickets has been deleted"
    redirect_to(projects_url)
  end
    

  protected
  
  def assign_project
    begin
      @project = current_user.projects.find(params[:id])
    rescue
      not_found!(projects_path) 
    end
  end


end
