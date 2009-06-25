class TicketsController < ApplicationController
  before_filter :assign_ticket, :only => [:show, :edit, :update, :destroy]

  def index
    if params[:project_id]
      @project = current_user.projects.find(params[:project_id])
      @tickets = @project.tickets
    else
      @tickets = current_user.tickets
    end
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end


  def edit
  end

  def create
    @ticket = current_user.tickets.new(params[:ticket].merge!(:project_id => params[:project_id]))
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    redirect_to(tickets_url)
  end


  protected
  
  def assign_ticket
    begin
      @ticket = current_user.tickets.find(params[:id])
    rescue
      not_found!(tickets_path) 
    end
  end


end
