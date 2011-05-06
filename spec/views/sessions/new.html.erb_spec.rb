require 'spec_helper'

describe "sessions/new.html.erb" do
  it "renders the form for login" do
    render
    view.should render_template(:new)
  end
end
