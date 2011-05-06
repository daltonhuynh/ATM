require 'spec_helper'

describe Withdrawal do
  
  it "can withdraw" do
    withdrawal = Withdrawal.new({:amount => 1})
    withdrawal.should be_valid
  end
  
  it "is invalid for an empty constructor" do
    withdrawal = Withdrawal.new
    withdrawal.should_not be_valid
  end
  
  it "is invalid for a negative amount" do
    withdrawal = Withdrawal.new({:amount => -1})
    withdrawal.should_not be_valid
  end

end
