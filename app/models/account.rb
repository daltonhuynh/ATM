class Account < ActiveRecord::Base
  
  attr_accessible :name, :balance
  
  validates_length_of :name, :minimum => 3, :maximum => 30
  validates_numericality_of :balance, 
                            :greater_than_or_equal_to => 0, 
                            :only_integer => true,
                            :message => "Insufficient funds in bank account"
  
  belongs_to :person
  
  has_many :withdrawals, :dependent => :destroy

end
