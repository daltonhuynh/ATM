class WithdrawalObserver < ActiveRecord::Observer
  
  # Ensures that there is enough remaining cash in the ATM before 
  # proceding with the transaction. Else, merges errors into 
  # Withdrawal
  def before_save(withdrawal)
    only = AtMachine.first
    only.cash += -1 * withdrawal.amount
    result = only.save

    unless result
      withdrawal.errors.merge!(only.errors)
    end
    result
  end
  
end