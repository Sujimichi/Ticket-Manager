require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController, "#route_for" do

  it "should map { :controller => 'user_sessions', :action => 'index' } to /user_sessions" do
    route_for(:controller => "user_sessions", :action => "index").should == "/user_sessions"
  end
  
  it "should map { :controller => 'user_sessions', :action => 'new' } to /user_sessions/new" do
    route_for(:controller => "user_sessions", :action => "new").should == "/user_sessions/new"
  end
  
  it "should map { :controller => 'user_sessions', :action => 'show', :id => 1 } to /user_sessions/1" do
    route_for(:controller => "user_sessions", :action => "show", :id => 1).should == "/user_sessions/1"
  end
  
  it "should map { :controller => 'user_sessions', :action => 'edit', :id => 1 } to /user_sessions/1/edit" do
    route_for(:controller => "user_sessions", :action => "edit", :id => 1).should == "/user_sessions/1/edit"
  end
  
  it "should map { :controller => 'user_sessions', :action => 'update', :id => 1} to /user_sessions/1" do
    route_for(:controller => "user_sessions", :action => "update", :id => 1).should == "/user_sessions/1"
  end
  
  it "should map { :controller => 'user_sessions', :action => 'destroy', :id => 1} to /user_sessions/1" do
    route_for(:controller => "user_sessions", :action => "destroy", :id => 1).should == "/user_sessions/1"
  end
  
end

describe UserSessionsController, "handling GET /user_sessions" do

  before do
    @user_session = mock_model(User_session)
    User_session.stub!(:find).and_return([@user_session])
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
  
  it "should find all user_sessions" do
    User_session.should_receive(:find).with(:all).and_return([@user_session])
    do_get
  end
  
  it "should assign the found user_sessions for the view" do
    do_get
    assigns[:user_sessions].should == [@user_session]
  end
end

describe UserSessionsController, "handling GET /user_sessions/1" do

  before do
    @user_session = mock_model(User_session)
    User_session.stub!(:find).and_return(@user_session)
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
  
  it "should find the user_session requested" do
    User_session.should_receive(:find).with("1").and_return(@user_session)
    do_get
  end
  
  it "should assign the found user_session for the view" do
    do_get
    assigns[:user_session].should equal(@user_session)
  end
end

describe UserSessionsController, "handling GET /user_sessions/new" do

  before do
    @user_session = mock_model(User_session)
    User_session.stub!(:new).and_return(@user_session)
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
  
  it "should create an new user_session" do
    User_session.should_receive(:new).and_return(@user_session)
    do_get
  end
  
  it "should not save the new user_session" do
    @user_session.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new user_session for the view" do
    do_get
    assigns[:user_session].should equal(@user_session)
  end
end

describe UserSessionsController, "handling GET /user_sessions/1/edit" do

  before do
    @user_session = mock_model(User_session)
    User_session.stub!(:find).and_return(@user_session)
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
  
  it "should find the user_session requested" do
    User_session.should_receive(:find).and_return(@user_session)
    do_get
  end
  
  it "should assign the found user_session for the view" do
    do_get
    assigns[:user_session].should equal(@user_session)
  end
end

describe UserSessionsController, "handling POST /user_sessions" do

  before do
    request.env["HTTP_REFERER"] = "/user_sessions/1"
    @user_session = mock_model(User_session, :to_param => "1")
    User_session.stub!(:new).and_return(@user_session)
  end
  
  def post_with_successful_save
    @user_session.should_receive(:save).and_return(true)
    post :create, :user_session => {}
  end
  
  def post_with_failed_save
    @user_session.should_receive(:save).and_return(false)
    post :create, :user_session => {}
  end
  
  it "should create a new user_session" do
    User_session.should_receive(:new).with({}).and_return(@user_session)
    post_with_successful_save
  end

  it "should redirect to the new user_session on successful save" do
    post_with_successful_save
    response.should redirect_to(user_session_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe UserSessionsController, "handling PUT /user_sessions/1" do

  before do
    @user_session = mock_model(User_session, :to_param => "1")
    User_session.stub!(:find).and_return(@user_session)
  end
  
  def put_with_successful_update
    @user_session.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @user_session.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the user_session requested" do
    User_session.should_receive(:find).with("1").and_return(@user_session)
    put_with_successful_update
  end

  it "should update the found user_session" do
    put_with_successful_update
    assigns(:user_session).should equal(@user_session)
  end

  it "should assign the found user_session for the view" do
    put_with_successful_update
    assigns(:user_session).should equal(@user_session)
  end

  it "should redirect to the user_session on successful update" do
    put_with_successful_update
    response.should redirect_to(user_session_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe UserSessionsController, "handling DELETE /user_session/1" do

  before do
    request.env["HTTP_REFERER"] = "/user_sessions"
    @user_session = mock_model(User_session, :destroy => true)
    User_session.stub!(:find).and_return(@user_session)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found user_session" do
    @user_session.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the user_sessions list" do
    do_delete
    response.should redirect_to(usersessions_url)
  end
end
