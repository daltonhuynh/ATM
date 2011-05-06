require 'spec_helper'

describe SessionsController do
  
  describe "GET new" do
    context "user is not signed in" do
      it "renders the new login template" do
        get :new
        response.should render_template(:new)
      end
    end
    
    context "user is signed in" do
      it "redirects to the accounts page" do
        
        current_user = Person.new
        controller.stub!(:current_user).and_return(current_user)
      
        get :new 
        response.should redirect_to(:controller => "accounts", :action => "index")
      
      end
    end
  end

  describe "POST create" do
    
    context "under the max number of login attempts" do 
      it "redirects to the accounts page on successful login" do
        params = {:session => {:name => "Test", :pin => "1234"}}
        
        current_user = Person.new
        current_user.should_receive(:id).and_return(1)
        
        LoginAttempt.should_receive(:attempts_secs_ago).and_return([])
        Person.stub!(:authenticate).and_return(current_user)
        
        post :create, params
                       
        response.should redirect_to(:controller => "accounts", :action => "index")
      end
    end
    
    context "equal or over the max number of attempts" do
      it "renders the new template" do 
        params = {:session => {:name => "Test", :pin => "1234"}}

        attempt = LoginAttempt.new
        attempt.should_receive(:created_at).and_return(Time.now)
        
        LoginAttempt.should_receive(:attempts_secs_ago).and_return([attempt, attempt, attempt])
        Person.stub!(:authenticate).and_return(nil)
        
        post :create, params
        
        response.should render_template(:new)
      end
    end
  end
  
  describe "DELETE destroy" do
    it "renders the new template" do
      controller.stub!(:reset_sessions).and_return(true)
      
      delete :destroy
      response.should redirect_to(:root)
    end
  end
  
end
