require File.dirname(__FILE__) + '/../spec_helper'

describe CommentsController, "#route_for" do

  it "should map { :controller => 'comments', :action => 'index' } to /comments" do
    route_for(:controller => "comments", :action => "index").should == "/comments"
  end
  
  it "should map { :controller => 'comments', :action => 'new' } to /comments/new" do
    route_for(:controller => "comments", :action => "new").should == "/comments/new"
  end
  
  it "should map { :controller => 'comments', :action => 'show', :id => 1 } to /comments/1" do
    route_for(:controller => "comments", :action => "show", :id => 1).should == "/comments/1"
  end
  
  it "should map { :controller => 'comments', :action => 'edit', :id => 1 } to /comments/1/edit" do
    route_for(:controller => "comments", :action => "edit", :id => 1).should == "/comments/1/edit"
  end
  
  it "should map { :controller => 'comments', :action => 'update', :id => 1} to /comments/1" do
    route_for(:controller => "comments", :action => "update", :id => 1).should == "/comments/1"
  end
  
  it "should map { :controller => 'comments', :action => 'destroy', :id => 1} to /comments/1" do
    route_for(:controller => "comments", :action => "destroy", :id => 1).should == "/comments/1"
  end
  
end

describe CommentsController, "handling GET /comments" do

  before do
    @comment = mock_model(Comment)
    Comment.stub!(:find).and_return([@comment])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all comments" do
    Comment.should_receive(:find).with(:all).and_return([@comment])
    do_get
  end
  
  it "should assign the found comments for the view" do
    do_get
    assigns[:comments].should == [@comment]
  end
end

describe CommentsController, "handling GET /comments/1" do

  before do
    @comment = mock_model(Comment)
    Comment.stub!(:find).and_return(@comment)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the comment requested" do
    Comment.should_receive(:find).with("1").and_return(@comment)
    do_get
  end
  
  it "should assign the found comment for the view" do
    do_get
    assigns[:comment].should equal(@comment)
  end
end

describe CommentsController, "handling GET /comments/new" do

  before do
    @comment = mock_model(Comment)
    Comment.stub!(:new).and_return(@comment)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new comment" do
    Comment.should_receive(:new).and_return(@comment)
    do_get
  end
  
  it "should not save the new comment" do
    @comment.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new comment for the view" do
    do_get
    assigns[:comment].should equal(@comment)
  end
end

describe CommentsController, "handling GET /comments/1/edit" do

  before do
    @comment = mock_model(Comment)
    Comment.stub!(:find).and_return(@comment)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the comment requested" do
    Comment.should_receive(:find).and_return(@comment)
    do_get
  end
  
  it "should assign the found comment for the view" do
    do_get
    assigns[:comment].should equal(@comment)
  end
end

describe CommentsController, "handling POST /comments" do

  before do
    request.env["HTTP_REFERER"] = "/comments/1"
    @comment = mock_model(Comment, :to_param => "1")
    Comment.stub!(:new).and_return(@comment)
  end
  
  def post_with_successful_save
    @comment.should_receive(:save).and_return(true)
    post :create, :comment => {}
  end
  
  def post_with_failed_save
    @comment.should_receive(:save).and_return(false)
    post :create, :comment => {}
  end
  
  it "should create a new comment" do
    Comment.should_receive(:new).with({}).and_return(@comment)
    post_with_successful_save
  end

  it "should redirect to the new comment on successful save" do
    post_with_successful_save
    response.should redirect_to(comment_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe CommentsController, "handling PUT /comments/1" do

  before do
    @comment = mock_model(Comment, :to_param => "1")
    Comment.stub!(:find).and_return(@comment)
  end
  
  def put_with_successful_update
    @comment.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @comment.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the comment requested" do
    Comment.should_receive(:find).with("1").and_return(@comment)
    put_with_successful_update
  end

  it "should update the found comment" do
    put_with_successful_update
    assigns(:comment).should equal(@comment)
  end

  it "should assign the found comment for the view" do
    put_with_successful_update
    assigns(:comment).should equal(@comment)
  end

  it "should redirect to the comment on successful update" do
    put_with_successful_update
    response.should redirect_to(comment_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe CommentsController, "handling DELETE /comment/1" do

  before do
    request.env["HTTP_REFERER"] = "/comments"
    @comment = mock_model(Comment, :destroy => true)
    Comment.stub!(:find).and_return(@comment)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found comment" do
    @comment.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the comments list" do
    do_delete
    response.should redirect_to(comments_url)
  end
end
