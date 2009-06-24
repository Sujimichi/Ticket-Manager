class TicketsController < ApplicationController
  
  # GET /tickets
  def index
    @tickets = Ticket.find(:all)
  end

  # GET /tickets/1
  def show
    @ticket = Ticket.find(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(params[:ticket])

    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /tickets/1
  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to(@ticket)
    else
      render :action => "edit"
    end
  end

  # DELETE /tickets/1
  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to(tickets_url)
  end
end
