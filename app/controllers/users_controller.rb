class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :assign_user_for_action, :only => [:edit, :update, :destroy]
  before_filter :assign_user_for_view , :only => [:show]

  def show
    
  end

  def index 
    if current_user.sys_admin?
      @users = User.all
    else
      @users = current_user.associates
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  protected
  
  def assign_user_for_action
    begin
      unless current_user.sys_admin?
        return not_allowed!(users_path) unless params[:id].to_i.eql?(current_user.id)
        @user = current_user
      else
        @user = User.find(params[:id]) 
      end
    rescue
      not_found!(users_path)
    end
  end

  def assign_user_for_view
    begin
      if current_user.sys_admin?
        @user = User.find(params[:id])
      elsif params[:id].to_i.eql?(current_user.id)
        @user = current_user
      else
        @user = current_user.associates.find(params[:id])
      end
    rescue
      not_found!(users_path)
    end
  end
      

end
