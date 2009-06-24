require File.dirname(__FILE__) + '/../spec_helper'

describe User_session do
  before(:each) do
    @user_session = User_session.new
  end

  it "should be valid" do
    @user_session.should be_valid
  end
end
