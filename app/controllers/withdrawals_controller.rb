class WithdrawalsController < ApplicationController
  before_filter :authorize

  def new
    @withdrawal = Withdrawal.new
    @withdrawal.account = Account.find(params[:account_id])
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
    
  def authorize
    @account = Account.find(params[:account_id])
    redirect_to root_path unless current_user && current_user.accounts.include?(@account)
  end

end
