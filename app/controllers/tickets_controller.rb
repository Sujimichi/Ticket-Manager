class TicketsController < ApplicationController
  before_filter :assign_ticket, :only => [:show, :edit, :update, :destroy, :close_ticket, :open_ticket, :hold_ticket, :invalidate_ticket, :change_priority]

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
    @ticket = Ticket.new(params[:ticket].merge!(:project_id => params[:project_id]))
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

  def close_ticket  
    @ticket.mark_closed
    return render :text  => "done" if request.xhr?
    redirect_to :back
  end

  def open_ticket
    @ticket.mark_open
    return render :text => "done" if request.xhr?
    redirect_to :back
  end

  def hold_ticket
    @ticket.mark_on_hold
    return render :text => "done" if request.xhr?
    redirect_to :back
  end
  
  def invalidate_ticket
    @ticket.mark_invalid
    return render :text => "done" if request.xhr?
    redirect_to :back
  end

  def change_priority
    set_high_priority if params[:priority].downcase.eql?("high")
    set_normal_priority if params[:priority].downcase.eql?("normal")
    set_low_priority if params[:priority].downcase.eql?("low")
  end
  def set_high_priority
    @ticket.update_attributes(:high_priority => true)
    render :partial => 'tickets/widget', :locals => {:ticket => @ticket}
  end
  def set_normal_priority
    @ticket.update_attributes(:high_priority => nil)  
    render :partial => 'tickets/widget', :locals => {:ticket => @ticket}
  end
  def set_low_priority
    @ticket.update_attributes(:high_priority => false)  
    render :partial => 'tickets/widget', :locals => {:ticket => @ticket}    
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
