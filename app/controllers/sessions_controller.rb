class SessionsController < ApplicationController
  
  MAX_ATTEMPTS = 3
  LOCK_OUT_TIME_SECS = 30 # number of seconds max_attempts allowed
  
  def new
    if current_user 
      redirect_to accounts_path  
      return
    end
  end
  
  def create    
    name = params[:session][:name]
    pin = params[:session][:pin]
    
    ip = request.remote_ip # Visitor IP
    last_attempts = LoginAttempt.attempts_secs_ago(ip, LOCK_OUT_TIME_SECS)
    
    if last_attempts.count < MAX_ATTEMPTS
      person = Person.authenticate(name, pin)
      if person
        session[:person_id] = person.id
        redirect_to accounts_path
        return
      end
    end
        
    if last_attempts.count + 1 < MAX_ATTEMPTS
      LoginAttempt.create({:ip => ip})
      notice = "Incorrect Name/Pin. #{MAX_ATTEMPTS - last_attempts.count} attempt(s) remaining"    
    else
      time_remaining = (last_attempts.first.created_at + LOCK_OUT_TIME_SECS.seconds) - Time.now
      notice = "#{time_remaining.to_i} seconds remaining until next retry"      
    end
        
    flash[:notice] = notice
    render :action => :new
  end
  
  def destroy 
    reset_session
    redirect_to root_path
  end
end
