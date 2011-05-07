class Withdrawal < ActiveRecord::Base
  
  attr_accessible :amount
    
  validates_presence_of :amount
  validates_numericality_of :amount, 
                            :greater_than => 0, 
                            :only_integer => true,
                            :message => "Must withdraw a positive amount"
  
  belongs_to :account  
    
  before_save :perform_withdrawal!
  
  # Withdraws the amount from its account. Parent
  # errors are merged in order to rollback if parent 
  # validation fails
  def perform_withdrawal!
    account = self.account
    
    account.transaction do
      self.account.balance += -1 * self.amount
    
      result = self.account.save
      unless result
        errors.merge!(self.account.errors)
      end
      result
    end
  end
  
end
