class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  MAX_ATTEMPTS = 3
  LOCK_OUT_TIME_SECS = 30 # number of seconds max_attempts allowed
  
  def new
    if current_user 
      redirect_to accounts_path  
      return
    end
  end
  
  def create    
    
    ip = request.remote_ip # Visitor IP
    remainder = LoginAttempt.attempts_remaining(ip, LOCK_OUT_TIME_SECS, MAX_ATTEMPTS)
    
    if remainder > 0
      
      name = params[:session][:name]
      pin = params[:session][:pin]
      
      person = Person.authenticate(name, pin)
      if person
        session[:person_id] = person.id
        redirect_to accounts_path
        return
      else
        LoginAttempt.create(:ip => ip)
        notice = remainder > 1 ? "Incorrect Name/Pin. #{remainder - 1} attempt(s) remaining" : 
                                 "#{LOCK_OUT_TIME_SECS} seconds remaining until next retry"
      end
    else
      notice = "#{LoginAttempt.secs_remaining(ip, LOCK_OUT_TIME_SECS).to_i} seconds remaining until next retry"
    end
        
    flash[:notice] = notice
    render :action => :new
  end
  
  def destroy 
    reset_session
    redirect_to root_path
  end

end
