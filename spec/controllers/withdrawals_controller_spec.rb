require 'spec_helper'

describe WithdrawalsController do

  describe "GET new" do
    it "renders the new template" do
      controller.stub(:authorize)
      controller.stub(:authorize_account)
                
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "authorized" do 
      
      before(:each) do
        controller.stub(:authorize)
        controller.stub(:authorize_account)
        
        @stub_withdrawal = Withdrawal.new
      end
        
      it "redirects to the index on successful save" do
        @stub_withdrawal.stub_chain(:errors, :any?).and_return(false)
        @stub_withdrawal.should_receive(:amount).and_return(1)
        
        assigns(:account).stub_chain(:withdrawals, :create).and_return(@stub_withdrawal)
      
        post :create
        response.should render_template(:controller => "accounts", :action => "index")
      end
  
      it "renders the new template on an unsuccessful save" do
        
        @stub_withdrawal.stub_chain(:errors, :any?).and_return(false)
        @stub_withdrawal.should_receive(:errors).and_return([{}])
                
        assigns(:account).stub_chain(:withdrawals, :create).and_return(@stub_withdrawal)
      
        post :create
        response.should render_template :new
      end
    end
    
    context "unauthorized" do
      it "redirects to the root path" do
        
        params = {:account_id => 1, :transaction => {:amount => 100, :type => "Deposit"}}
        post :create, params
      
        response.should redirect_to(root_path)
      end
    end
  end

end
