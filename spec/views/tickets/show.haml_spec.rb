require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tickets/show.haml" do
  before do
    @ticket = mock_model(Ticket)
    @ticket.stub!(:number).and_return("1")
    @ticket.stub!(:title).and_return("MyString")

    assigns[:ticket] = @ticket
  end

  it "should render attributes in <p>" do
    render "/tickets/show.haml"
    response.should have_text(/1/)
    response.should have_text(/MyString/)
  end
end

