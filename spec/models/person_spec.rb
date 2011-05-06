require 'spec_helper'

TEST_NAME = "Test"
TEST_PIN = "1234"
TEST_FALSE_PIN = "1111"

describe Person do
  before(:each) do     
    Person.destroy_all
    
    @person = Person.new
    @person.name = TEST_NAME
    @person.pin = TEST_PIN
    @person.save!
  end
  
  it "can authenticate a valid user" do
    Person.authenticate(@person.name, TEST_PIN).should_not be_nil
  end
  
  it "can fail an invalid pin for a user" do
    Person.authenticate(@person.name, TEST_FALSE_PIN).should be_nil
  end
  
  it "will prevent the creation of multiple users of the same name" do
    expect {
      
      dup = Person.new
      dup.name = TEST_NAME
      dup.pin = TEST_PIN
      dup.save!
      
    }.to raise_error
  end
  
  it "has many accounts" do 
    @person.accounts.count.should be > 0
  end
  
  it "will destroy all associated accounts of a removed user" do
    id = @person.id
    @person.destroy
    
    Account.find_by_person_id(id).should be_nil
  end
  
end
