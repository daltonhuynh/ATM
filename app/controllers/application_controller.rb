class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authorize
  
  helper_method :current_user

protected
  
  def authorize
    redirect_to root_path unless current_user
  end
  
private 

  def current_user
    id = session[:person_id]
    Person.find(id) if id
  end
  
end
