class LoginAttempt < ActiveRecord::Base
  
  attr_accessible :ip
  
  # returns the attempts N number of seconds ago from an IP
  def self.attempts_secs_ago(ip, secs) 
    frame = Time.now - secs
    where(["ip = ? AND created_at > ?", ip, frame]).order("created_at DESC")
  end
  
end
