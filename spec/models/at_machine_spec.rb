require 'spec_helper'

describe AtMachine do
  before(:each) do    
    AtMachine.destroy_all
  end
  
  it "should be default to cash 0" do
    AtMachine.create
    AtMachine.first.cash.should eq(0)
  end
  
  it "should be able to set to cash amount" do
    AtMachine.create(:cash => 2000)
    AtMachine.first.cash.should eq(2000)
  end
  
  it "adds cash to the machine" do
    AtMachine.create
    only = AtMachine.first
    only.cash += 30
    only.cash.should eq(30)
  end
  
  it "withdraws cash from the machine" do 
    AtMachine.create
    only = AtMachine.first
    only.cash += 30    
    only.cash -= 25
    
    only.cash.should eq(5)
  end
  
  it "is invalid if cash on hand is below 0" do 
    AtMachine.create
    only = AtMachine.first
    only.cash -= 1    
    only.should_not be_valid
  end
  
end
