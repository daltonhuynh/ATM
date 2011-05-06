require 'spec_helper'

describe "accounts/index.html.erb" do
  
  it "renders the list of accounts for a user" do
    assign(:current_user, stub_model(Person))
    assign(:accounts, [stub_model(Account), stub_model(Account)])
    render
    view.should render_template(:partial => "_account", :count => 2)
  end
  
end
