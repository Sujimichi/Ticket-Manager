class ChangeLogsController < ApplicationController
  
  # GET /change_logs
  def index
    @change_logs = Change_log.find(:all)
  end

  # GET /change_logs/1
  def show
    @change_log = Change_log.find(params[:id])
  end

  # GET /change_logs/new
  def new
    @change_log = Change_log.new
  end

  # GET /change_logs/1/edit
  def edit
    @change_log = Change_log.find(params[:id])
  end

  # POST /change_logs
  def create
    @change_log = Change_log.new(params[:change_log])

    if @change_log.save
      flash[:notice] = 'Change_log was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /change_logs/1
  def update
    @change_log = Change_log.find(params[:id])

    if @change_log.update_attributes(params[:change_log])
      flash[:notice] = 'Change_log was successfully updated.'
      redirect_to(@change_log)
    else
      render :action => "edit"
    end
  end

  # DELETE /change_logs/1
  def destroy
    Change_log.find(params[:id]).destroy
    redirect_to(change_logs_url)
  end
end
