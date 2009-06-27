class TicketsController < ApplicationController
  before_filter :assign_ticket, :only => [:show, :edit, :update, :destroy, :change_priority, :change_status]

  def index
    if params[:project_id]
      @project = current_user.projects.find(params[:project_id])
      @ticket_type = params[:ticket_type].to_sym if params[:ticket_type] 
      
      @tickets = @project.active_tickets if @ticket_type.eql?(:active)
      @tickets = @project.closed_tickets if @ticket_type.eql?(:closed)
      @tickets = @project.on_hold_tickets if @ticket_type.eql?(:on_hold)
      @tickets = @project.invalid_tickets if @ticket_type.eql?(:invalid)
      @tickets ||= @project.tickets
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
    @ticket = Ticket.new(params[:ticket].merge!(:project_id => params[:project_id], :user_id => current_user.id))
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :back
    else
      flash[:error] = 'Ticket cannot be created!'
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
    project = @ticket.project
    @ticket.destroy
    redirect_to(project_tickets_path(project))
  end

  def change_status
    @ticket.mark_closed if params[:change_to].eql?('closed')
    @ticket.mark_active if params[:change_to].eql?('active')
    @ticket.mark_on_hold if params[:change_to].gsub(" ", "_").eql?('on_hold')
    @ticket.mark_invalid if params[:change_to].eql?('invalid')    
    return render :partial => 'tickets/widget', :locals => {:ticket => @ticket} if request.xhr?
    redirect_to :back
  end

  def change_priority
    @ticket.update_attributes(:high_priority => true) if params[:priority].downcase.eql?("high")
    @ticket.update_attributes(:high_priority => nil)  if params[:priority].downcase.eql?("normal")
    @ticket.update_attributes(:high_priority => false)if params[:priority].downcase.eql?("low")
    return render :partial => 'tickets/widget', :locals => {:ticket => @ticket} if request.xhr?
    redirect_to :back
  end

  protected
  
  def assign_ticket
    begin
      @ticket = Ticket.find(:first, :conditions => ["project_id IN (?) AND id = ?", current_user.projects.map{|p| p.id}, params[:id]])
    rescue
      not_found!(tickets_path) 
    end
  end


end
