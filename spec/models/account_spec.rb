require 'spec_helper'

describe Account do
  
  before(:each) do     
    @account = Account.new({:name => "Checking"})
  end
  
  it "defaults to a balance of 0" do
    @account.balance.should eq(0)
  end
  
  it "can increment to positive amounts" do 
    @account.balance += 1
    @account.balance.should eq(1)
  end
  
  it "can decrement its balance" do 
    @account.balance += 10
    @account.balance += -1
    
    @account.balance.should eq(9)
  end
  
  it "can process multiple deposits and withdrawals" do
        
    (1..10).each {|x| @account.balance += x}
    (1..10).each {|x| @account.balance -= x}
    
    @account.balance.should eq(0)

  end
  
  it "is invalid when the balance is below 0" do 
    @account.balance += -1
    @account.should_not be_valid
  end
  
  context "with a machine and account balance of 0" do
    
    it "is invalid withdrawing more than is in its balance" do 
      @account.save!
      expect{
        result = @account.withdrawals.create({:amount => 1})
        result.account.save!
      }.to raise_error
    end
    
  end
  
end
