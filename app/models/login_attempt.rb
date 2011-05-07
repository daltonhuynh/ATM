class LoginAttempt < ActiveRecord::Base
  
  attr_accessible :ip

  # returns the number of remaining attempts within a given 
  # time and for a given amount for an ip
  def self.attempts_remaining(ip, secs, max)
    frame = Time.now - secs
    latest = where(["ip = ? AND created_at > ?", ip, frame])
        
    max - latest.count
  end
  
  def self.secs_remaining(ip, secs)
    (latest_attempt(ip).created_at + secs) - Time.now
  end
  
  def self.latest_attempt(ip)
    find(:first, :conditions => ["ip = ?", ip], :order => "created_at DESC")
  end
  
end
