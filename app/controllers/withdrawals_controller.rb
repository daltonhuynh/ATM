class WithdrawalsController < ApplicationController
  before_filter :authorize_account

  def new
    @withdrawal = Withdrawal.new
    @withdrawal.account = @account
  end

  def create
    
    @withdrawal = @account.withdrawals.create(params[:withdrawal])
    unless @withdrawal.errors.any?
      redirect_to(accounts_path, 
        :notice => "Withdrawal of $#{@withdrawal.amount} successful!")
    else
      @errors = @withdrawal.errors
      render :new
    end
  end
    
protected
    
  def authorize_account
    @account = Account.find(params[:account_id])
    redirect_to accounts_path unless @account.person == current_user
  end

end
