require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tickets/index.haml" do
  before do
    ticket_98 = mock_model(Ticket)
    ticket_98.should_receive(:number).and_return("1")
    ticket_98.should_receive(:title).and_return("MyString")
    ticket_99 = mock_model(Ticket)
    ticket_99.should_receive(:number).and_return("1")
    ticket_99.should_receive(:title).and_return("MyString")

    assigns[:tickets] = [ticket_98, ticket_99]
  end

  it "should render list of tickets" do
    render "/tickets/index.haml"
  end
end
