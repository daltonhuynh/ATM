require 'spec_helper'

describe WithdrawalsController do

  describe "GET new" do
    it "renders the new template" do
    
      controller.stub!(:authorize)
      Account.stub!(:find).and_return(Account.new)
      
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "authorized" do 
      context "successful save" do 
    
        it "redirects to the index" do
          current_user = Person.new
          current_user.stub_chain(:accounts, :include?).and_return(true)
          controller.stub!(:current_user).and_return(current_user)
          
          params = {:account_id => 1, :transaction => {:amount => 100, :type => "Deposit"}}
              
          current_account = Account.new
          
          stub = Withdrawal.new
          stub.should_receive(:errors).and_return([])
          
          current_account.stub_chain(:withdrawals, :create).and_return(stub)
          Account.stub!(:find).and_return(current_account)
        
          post :create, params
          response.should render_template(:controller => "accounts", :action => "index")
        end
      end
    
      context "unsuccessful save" do 
        it "reloads the new template" do
          current_user = Person.new
          current_user.stub_chain(:accounts, :include?).and_return(true)
          controller.stub!(:current_user).and_return(current_user)
          
          params = {:account_id => 1, :transaction => {:amount => 100, :type => "Deposit"}}
              
          current_account = Account.new
          
          stub = Withdrawal.new
          stub.stub_chain(:errors, :any?).and_return(true)
          stub.should_receive(:errors).and_return([{}])
          
          current_account.stub_chain(:withdrawals, :create).and_return(stub)
          Account.stub!(:find).and_return(current_account)
        
          post :create, params
          response.should render_template(:new)
        end
      end
    end
    
    context "unauthorized" do
      it "redirects to the root path" do
        Account.stub!(:find).and_return(Account.new)
        
        params = {:account_id => 1, :transaction => {:amount => 100, :type => "Deposit"}}
        post :create, params
      
        response.should redirect_to(root_path)
      end
    end
  end

end
