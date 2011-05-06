require 'spec_helper'

describe LoginAttempt do

  it "can return the 5 latest logins for an ip" do
    
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.2")
    LoginAttempt.create(:ip => "127.0.0.4")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.3")
    LoginAttempt.create(:ip => "127.0.0.1")
    LoginAttempt.create(:ip => "127.0.0.5")
    
    results = LoginAttempt.attempts_secs_ago("127.0.0.1", 1)
    
    results.count.should eq(5)
    
  end

end
