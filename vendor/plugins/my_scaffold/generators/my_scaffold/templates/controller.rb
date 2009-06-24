class <%= controller_class_name %>Controller < ApplicationController
  
  # GET /<%= controller_plural_name %>
  def index
    @<%= controller_plural_name %> = <%= name.capitalize %>.find(:all)
  end

  # GET /<%= controller_plural_name %>/1
  def show
    @<%= singular_name %> = <%= name.capitalize %>.find(params[:id])
  end

  # GET /<%= controller_plural_name %>/new
  def new
    @<%= singular_name %> = <%= name.capitalize %>.new
  end

  # GET /<%= controller_plural_name %>/1/edit
  def edit
    @<%= singular_name %> = <%= name.capitalize %>.find(params[:id])
  end

  # POST /<%= controller_plural_name %>
  def create
    @<%= singular_name %> = <%= name.capitalize %>.new(params[:<%= singular_name %>])

    if @<%= singular_name %>.save
      flash[:notice] = '<%= name.capitalize %> was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /<%= controller_plural_name %>/1
  def update
    @<%= singular_name %> = <%= name.capitalize %>.find(params[:id])

    if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
      flash[:notice] = '<%= name.capitalize %> was successfully updated.'
      redirect_to(@<%= singular_name %>)
    else
      render :action => "edit"
    end
  end

  # DELETE /<%= controller_plural_name %>/1
  def destroy
    <%= name.capitalize %>.find(params[:id]).destroy
    redirect_to(<%= singular_name.pluralize %>_url)
  end
end
