class CommentsController < ApplicationController
  before_filter :assign_comment, :only => [:show, :edit, :update, :destroy]

  def index
    @comments = current_user.comments.find(:all)
  end

  def show
  end

  def new
    @comment = Comment.new
  end


  def edit
  end

  def create
    @comment = current_user.comments.new(params[:comment])

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to(@comment)
    else
      render :action => "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to(comments_url)
  end


  protected
  
  def assign_comment
    begin
      @comment = current_user.comments.find(params[:id])
    rescue
      not_found!(comments_path) 
    end
  end


end
