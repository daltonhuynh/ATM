class AtMachine < ActiveRecord::Base  
  
  attr_accessible :cash
  
  validates_numericality_of :cash, 
                            :greater_than_or_equal_to => 0, 
                            :only_integer => true,
                            :message => "Insufficient amount of cash in ATM"
                            
end