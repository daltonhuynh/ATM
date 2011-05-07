require 'spec_helper'

describe LoginAttempt do
  
  before(:each) do
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.2")
    LoginAttempt.create(:ip => "127.0.0.4")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.3")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.5")
  end

  it "can return the attempts_remaining" do
    result = LoginAttempt.attempts_remaining("127.0.0.1", 0, 0)
    result.should eq(0)
  end
  
  it "returns the secs_remaining for an ip" do
    secs = LoginAttempt.secs_remaining("127.0.0.1", 0)
    secs.should be < 0
  end
  
  it "returns the latest_attempt for an ip" do 
    attempt = LoginAttempt.create(:ip => "127.0.0.1")
    result = LoginAttempt.latest_attempt("127.0.0.1")
    
    result.should eq(attempt)
  end

end
