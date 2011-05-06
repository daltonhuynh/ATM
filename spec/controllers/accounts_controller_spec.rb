require 'spec_helper'

describe AccountsController do

  describe "GET index" do
    context "authrorized" do
      it "renders the accounts index" do
                
        current_user = Person.new
        controller.stub!(:current_user).and_return(current_user)
        
        current_user.should_receive(:accounts).and_return([])
        
        get :index
        response.should render_template(:index)
      end
    end
    
    context "unauthorized" do
      it "redirects to the root" do
        get :index
        response.should redirect_to(:root)
      end
    end
    
  end
  
  describe "GET show" do
    context "authorized" do
      it "renders the account history" do
        
        current_user = Person.new
        current_user.stub_chain(:accounts, :include?).and_return(true)
        controller.stub!(:current_user).and_return(current_user)
        
        current_account = Account.new
        Account.should_receive(:find).and_return(current_account)
        
        get :show, :id => 1
        
        response.should be_success
      end
    end
    
    context "unauthorized" do
      it "redirects to the root" do
        get :show, :id => 1
        response.should redirect_to(:root)
      end
    end
  end

end
