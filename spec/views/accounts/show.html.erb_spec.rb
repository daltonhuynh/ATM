require 'spec_helper'

describe "accounts/show.html.erb" do
  
  it "renders the withdrawal history" do
    assign(:account, stub_model(Account))
    
    stub = Withdrawal.new
    stub.should_receive(:created_at).and_return(Time.now)
    
    assign(:withdrawals, [stub])
    
    render
    view.should render_template(:show)
  end
  
end
