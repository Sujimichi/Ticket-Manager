require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ticket/edit.haml" do
  before do
    @ticket = mock_model(Ticket)
    @ticket.stub!(:number).and_return("1")
    @ticket.stub!(:title).and_return("MyString")
    assigns[:ticket] = @ticket
  end

  it "should render edit form" do
    render "/tickets/edit.haml"
    
    response.should have_tag("form[action=#{ticket_path(@ticket)}][method=post]") do
      with_tag('input#ticket_number[name=?]', "ticket[number]")
      with_tag('input#ticket_title[name=?]', "ticket[title]")
    end
  end
end
