require File.dirname(__FILE__) + '/../spec_helper'

describe ChangeLogsController, "#route_for" do

  it "should map { :controller => 'change_logs', :action => 'index' } to /change_logs" do
    route_for(:controller => "change_logs", :action => "index").should == "/change_logs"
  end
  
  it "should map { :controller => 'change_logs', :action => 'new' } to /change_logs/new" do
    route_for(:controller => "change_logs", :action => "new").should == "/change_logs/new"
  end
  
  it "should map { :controller => 'change_logs', :action => 'show', :id => 1 } to /change_logs/1" do
    route_for(:controller => "change_logs", :action => "show", :id => 1).should == "/change_logs/1"
  end
  
  it "should map { :controller => 'change_logs', :action => 'edit', :id => 1 } to /change_logs/1/edit" do
    route_for(:controller => "change_logs", :action => "edit", :id => 1).should == "/change_logs/1/edit"
  end
  
  it "should map { :controller => 'change_logs', :action => 'update', :id => 1} to /change_logs/1" do
    route_for(:controller => "change_logs", :action => "update", :id => 1).should == "/change_logs/1"
  end
  
  it "should map { :controller => 'change_logs', :action => 'destroy', :id => 1} to /change_logs/1" do
    route_for(:controller => "change_logs", :action => "destroy", :id => 1).should == "/change_logs/1"
  end
  
end

describe ChangeLogsController, "handling GET /change_logs" do

  before do
    @change_log = mock_model(Change_log)
    Change_log.stub!(:find).and_return([@change_log])
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
  
  it "should find all change_logs" do
    Change_log.should_receive(:find).with(:all).and_return([@change_log])
    do_get
  end
  
  it "should assign the found change_logs for the view" do
    do_get
    assigns[:change_logs].should == [@change_log]
  end
end

describe ChangeLogsController, "handling GET /change_logs/1" do

  before do
    @change_log = mock_model(Change_log)
    Change_log.stub!(:find).and_return(@change_log)
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
  
  it "should find the change_log requested" do
    Change_log.should_receive(:find).with("1").and_return(@change_log)
    do_get
  end
  
  it "should assign the found change_log for the view" do
    do_get
    assigns[:change_log].should equal(@change_log)
  end
end

describe ChangeLogsController, "handling GET /change_logs/new" do

  before do
    @change_log = mock_model(Change_log)
    Change_log.stub!(:new).and_return(@change_log)
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
  
  it "should create an new change_log" do
    Change_log.should_receive(:new).and_return(@change_log)
    do_get
  end
  
  it "should not save the new change_log" do
    @change_log.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new change_log for the view" do
    do_get
    assigns[:change_log].should equal(@change_log)
  end
end

describe ChangeLogsController, "handling GET /change_logs/1/edit" do

  before do
    @change_log = mock_model(Change_log)
    Change_log.stub!(:find).and_return(@change_log)
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
  
  it "should find the change_log requested" do
    Change_log.should_receive(:find).and_return(@change_log)
    do_get
  end
  
  it "should assign the found change_log for the view" do
    do_get
    assigns[:change_log].should equal(@change_log)
  end
end

describe ChangeLogsController, "handling POST /change_logs" do

  before do
    request.env["HTTP_REFERER"] = "/change_logs/1"
    @change_log = mock_model(Change_log, :to_param => "1")
    Change_log.stub!(:new).and_return(@change_log)
  end
  
  def post_with_successful_save
    @change_log.should_receive(:save).and_return(true)
    post :create, :change_log => {}
  end
  
  def post_with_failed_save
    @change_log.should_receive(:save).and_return(false)
    post :create, :change_log => {}
  end
  
  it "should create a new change_log" do
    Change_log.should_receive(:new).with({}).and_return(@change_log)
    post_with_successful_save
  end

  it "should redirect to the new change_log on successful save" do
    post_with_successful_save
    response.should redirect_to(change_log_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ChangeLogsController, "handling PUT /change_logs/1" do

  before do
    @change_log = mock_model(Change_log, :to_param => "1")
    Change_log.stub!(:find).and_return(@change_log)
  end
  
  def put_with_successful_update
    @change_log.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @change_log.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the change_log requested" do
    Change_log.should_receive(:find).with("1").and_return(@change_log)
    put_with_successful_update
  end

  it "should update the found change_log" do
    put_with_successful_update
    assigns(:change_log).should equal(@change_log)
  end

  it "should assign the found change_log for the view" do
    put_with_successful_update
    assigns(:change_log).should equal(@change_log)
  end

  it "should redirect to the change_log on successful update" do
    put_with_successful_update
    response.should redirect_to(change_log_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ChangeLogsController, "handling DELETE /change_log/1" do

  before do
    request.env["HTTP_REFERER"] = "/change_logs"
    @change_log = mock_model(Change_log, :destroy => true)
    Change_log.stub!(:find).and_return(@change_log)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found change_log" do
    @change_log.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the change_logs list" do
    do_delete
    response.should redirect_to(changelogs_url)
  end
end
