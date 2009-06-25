require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController, "#route_for" do

  it "should map { :controller => 'projects', :action => 'index' } to /projects" do
    route_for(:controller => "projects", :action => "index").should == "/projects"
  end
  
  it "should map { :controller => 'projects', :action => 'new' } to /projects/new" do
    route_for(:controller => "projects", :action => "new").should == "/projects/new"
  end
  
  it "should map { :controller => 'projects', :action => 'show', :id => 1 } to /projects/1" do
    route_for(:controller => "projects", :action => "show", :id => 1).should == "/projects/1"
  end
  
  it "should map { :controller => 'projects', :action => 'edit', :id => 1 } to /projects/1/edit" do
    route_for(:controller => "projects", :action => "edit", :id => 1).should == "/projects/1/edit"
  end
  
  it "should map { :controller => 'projects', :action => 'update', :id => 1} to /projects/1" do
    route_for(:controller => "projects", :action => "update", :id => 1).should == "/projects/1"
  end
  
  it "should map { :controller => 'projects', :action => 'destroy', :id => 1} to /projects/1" do
    route_for(:controller => "projects", :action => "destroy", :id => 1).should == "/projects/1"
  end
  
end

describe ProjectsController, "handling GET /projects" do

  before do
    @project = mock_model(Project)
    Project.stub!(:find).and_return([@project])
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
  
  it "should find all projects" do
    Project.should_receive(:find).with(:all).and_return([@project])
    do_get
  end
  
  it "should assign the found projects for the view" do
    do_get
    assigns[:projects].should == [@project]
  end
end

describe ProjectsController, "handling GET /projects/1" do

  before do
    @project = mock_model(Project)
    Project.stub!(:find).and_return(@project)
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
  
  it "should find the project requested" do
    Project.should_receive(:find).with("1").and_return(@project)
    do_get
  end
  
  it "should assign the found project for the view" do
    do_get
    assigns[:project].should equal(@project)
  end
end

describe ProjectsController, "handling GET /projects/new" do

  before do
    @project = mock_model(Project)
    Project.stub!(:new).and_return(@project)
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
  
  it "should create an new project" do
    Project.should_receive(:new).and_return(@project)
    do_get
  end
  
  it "should not save the new project" do
    @project.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new project for the view" do
    do_get
    assigns[:project].should equal(@project)
  end
end

describe ProjectsController, "handling GET /projects/1/edit" do

  before do
    @project = mock_model(Project)
    Project.stub!(:find).and_return(@project)
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
  
  it "should find the project requested" do
    Project.should_receive(:find).and_return(@project)
    do_get
  end
  
  it "should assign the found project for the view" do
    do_get
    assigns[:project].should equal(@project)
  end
end

describe ProjectsController, "handling POST /projects" do

  before do
    request.env["HTTP_REFERER"] = "/projects/1"
    @project = mock_model(Project, :to_param => "1")
    Project.stub!(:new).and_return(@project)
  end
  
  def post_with_successful_save
    @project.should_receive(:save).and_return(true)
    post :create, :project => {}
  end
  
  def post_with_failed_save
    @project.should_receive(:save).and_return(false)
    post :create, :project => {}
  end
  
  it "should create a new project" do
    Project.should_receive(:new).with({}).and_return(@project)
    post_with_successful_save
  end

  it "should redirect to the new project on successful save" do
    post_with_successful_save
    response.should redirect_to(project_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ProjectsController, "handling PUT /projects/1" do

  before do
    @project = mock_model(Project, :to_param => "1")
    Project.stub!(:find).and_return(@project)
  end
  
  def put_with_successful_update
    @project.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @project.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the project requested" do
    Project.should_receive(:find).with("1").and_return(@project)
    put_with_successful_update
  end

  it "should update the found project" do
    put_with_successful_update
    assigns(:project).should equal(@project)
  end

  it "should assign the found project for the view" do
    put_with_successful_update
    assigns(:project).should equal(@project)
  end

  it "should redirect to the project on successful update" do
    put_with_successful_update
    response.should redirect_to(project_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ProjectsController, "handling DELETE /project/1" do

  before do
    request.env["HTTP_REFERER"] = "/projects"
    @project = mock_model(Project, :destroy => true)
    Project.stub!(:find).and_return(@project)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found project" do
    @project.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the projects list" do
    do_delete
    response.should redirect_to(projects_url)
  end
end
