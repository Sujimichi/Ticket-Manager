require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tickets/new.haml" do
  before do
    @ticket = mock_model(Ticket)
    @ticket.stub!(:new_record?).and_return(true)
    @ticket.stub!(:number).and_return("1")
    @ticket.stub!(:title).and_return("MyString")
    assigns[:ticket] = @ticket
  end

  it "should render new form" do
    render "/tickets/new.haml"
    
    response.should have_tag("form[action=?][method=post]", tickets_path) do
      with_tag("input#ticket_number[name=?]", "ticket[number]")
      with_tag("input#ticket_title[name=?]", "ticket[title]")
    end
  end
end
