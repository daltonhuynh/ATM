class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  
  def current_user
    id = session[:person_id]
    Person.find(id) if id
  end
  
  # to prevent non-logged in users from viewing accounts
  def authorize
    redirect_to root_path unless current_user
  end
end
