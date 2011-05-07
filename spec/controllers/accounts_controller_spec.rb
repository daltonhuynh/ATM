require 'spec_helper'

describe AccountsController do

  describe "GET index" do
    context "authorized" do
      it "renders the accounts index" do
        controller.stub(:authorize)
        controller.stub(:authorize_account)
        
        controller.stub(:current_user).and_return(Person.new)
        controller.stub_chain(:current_user, :accounts, :exists).and_return(true)
        
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
        
        assigns(:account).stub_chain(:withdrawals, :all).and_return(stub_model(Withdrawal))

        controller.stub(:authorize)
        controller.stub(:authorize_account)   
        
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
