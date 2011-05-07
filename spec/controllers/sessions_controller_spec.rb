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
      
      it "renders the login page again" do
        params = {:session => {:name => "Test", :pin => "1234"}}   

        LoginAttempt.should_receive(:attempts_remaining).and_return(3)
        
        Person.stub!(:authenticate).and_return(nil)
        
        post :create, params

        response.should render_template :new
      end
      
      it "redirects to the accounts page on successful login" do
        params = {:session => {:name => "Test", :pin => "1234"}}   
        
        LoginAttempt.should_receive(:attempts_remaining).and_return(3)
     
        current_user = Person.new
        current_user.should_receive(:id).and_return(1)
        
        Person.stub!(:authenticate).and_return(current_user)
        
        post :create, params
                       
        response.should redirect_to(:controller => "accounts", :action => "index")
      end
    end
    
    context "equal or over the max number of attempts" do
      
      it "renders the new template" do 
        params = {:session => {:name => "Test", :pin => "1234"}}
        
        LoginAttempt.should_receive(:attempts_remaining).and_return(0)
        LoginAttempt.should_receive(:secs_remaining).and_return(0)

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
