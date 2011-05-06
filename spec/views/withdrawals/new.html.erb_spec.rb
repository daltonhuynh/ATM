require 'spec_helper'

describe "withdrawals/new.html.erb" do
  it "renders the withdrawal form" do
    assign(:account, stub_model(Account))
    stub = Withdrawal.new
    stub.stub_chain(:account, :id).and_return(1)
    assign(:withdrawal, stub)
    
    render
    view.should render_template(:partial => "_form")
  end
end
