require File.dirname(__FILE__) + '/../spec_helper'

describe Change_log do
  before(:each) do
    @change_log = Change_log.new
  end

  it "should be valid" do
    @change_log.should be_valid
  end
end
