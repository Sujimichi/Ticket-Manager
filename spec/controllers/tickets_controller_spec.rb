require File.dirname(__FILE__) + '/../spec_helper'

describe TicketsController, "#route_for" do

  it "should map { :controller => 'tickets', :action => 'index' } to /tickets" do
    route_for(:controller => "tickets", :action => "index").should == "/tickets"
  end
  
  it "should map { :controller => 'tickets', :action => 'new' } to /tickets/new" do
    route_for(:controller => "tickets", :action => "new").should == "/tickets/new"
  end
  
  it "should map { :controller => 'tickets', :action => 'show', :id => 1 } to /tickets/1" do
    route_for(:controller => "tickets", :action => "show", :id => 1).should == "/tickets/1"
  end
  
  it "should map { :controller => 'tickets', :action => 'edit', :id => 1 } to /tickets/1/edit" do
    route_for(:controller => "tickets", :action => "edit", :id => 1).should == "/tickets/1/edit"
  end
  
  it "should map { :controller => 'tickets', :action => 'update', :id => 1} to /tickets/1" do
    route_for(:controller => "tickets", :action => "update", :id => 1).should == "/tickets/1"
  end
  
  it "should map { :controller => 'tickets', :action => 'destroy', :id => 1} to /tickets/1" do
    route_for(:controller => "tickets", :action => "destroy", :id => 1).should == "/tickets/1"
  end
  
end

describe TicketsController, "handling GET /tickets" do

  before do
    @ticket = mock_model(Ticket)
    Ticket.stub!(:find).and_return([@ticket])
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
  
  it "should find all tickets" do
    Ticket.should_receive(:find).with(:all).and_return([@ticket])
    do_get
  end
  
  it "should assign the found tickets for the view" do
    do_get
    assigns[:tickets].should == [@ticket]
  end
end

describe TicketsController, "handling GET /tickets/1" do

  before do
    @ticket = mock_model(Ticket)
    Ticket.stub!(:find).and_return(@ticket)
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
  
  it "should find the ticket requested" do
    Ticket.should_receive(:find).with("1").and_return(@ticket)
    do_get
  end
  
  it "should assign the found ticket for the view" do
    do_get
    assigns[:ticket].should equal(@ticket)
  end
end

describe TicketsController, "handling GET /tickets/new" do

  before do
    @ticket = mock_model(Ticket)
    Ticket.stub!(:new).and_return(@ticket)
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
  
  it "should create an new ticket" do
    Ticket.should_receive(:new).and_return(@ticket)
    do_get
  end
  
  it "should not save the new ticket" do
    @ticket.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new ticket for the view" do
    do_get
    assigns[:ticket].should equal(@ticket)
  end
end

describe TicketsController, "handling GET /tickets/1/edit" do

  before do
    @ticket = mock_model(Ticket)
    Ticket.stub!(:find).and_return(@ticket)
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
  
  it "should find the ticket requested" do
    Ticket.should_receive(:find).and_return(@ticket)
    do_get
  end
  
  it "should assign the found ticket for the view" do
    do_get
    assigns[:ticket].should equal(@ticket)
  end
end

describe TicketsController, "handling POST /tickets" do

  before do
    request.env["HTTP_REFERER"] = "/tickets/1"
    @ticket = mock_model(Ticket, :to_param => "1")
    Ticket.stub!(:new).and_return(@ticket)
  end
  
  def post_with_successful_save
    @ticket.should_receive(:save).and_return(true)
    post :create, :ticket => {}
  end
  
  def post_with_failed_save
    @ticket.should_receive(:save).and_return(false)
    post :create, :ticket => {}
  end
  
  it "should create a new ticket" do
    Ticket.should_receive(:new).with({}).and_return(@ticket)
    post_with_successful_save
  end

  it "should redirect to the new ticket on successful save" do
    post_with_successful_save
    response.should redirect_to(ticket_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe TicketsController, "handling PUT /tickets/1" do

  before do
    @ticket = mock_model(Ticket, :to_param => "1")
    Ticket.stub!(:find).and_return(@ticket)
  end
  
  def put_with_successful_update
    @ticket.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @ticket.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the ticket requested" do
    Ticket.should_receive(:find).with("1").and_return(@ticket)
    put_with_successful_update
  end

  it "should update the found ticket" do
    put_with_successful_update
    assigns(:ticket).should equal(@ticket)
  end

  it "should assign the found ticket for the view" do
    put_with_successful_update
    assigns(:ticket).should equal(@ticket)
  end

  it "should redirect to the ticket on successful update" do
    put_with_successful_update
    response.should redirect_to(ticket_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe TicketsController, "handling DELETE /ticket/1" do

  before do
    request.env["HTTP_REFERER"] = "/tickets"
    @ticket = mock_model(Ticket, :destroy => true)
    Ticket.stub!(:find).and_return(@ticket)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found ticket" do
    @ticket.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the tickets list" do
    do_delete
    response.should redirect_to(tickets_url)
  end
end
