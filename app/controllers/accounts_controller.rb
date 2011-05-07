class AccountsController < ApplicationController
  before_filter :authorize_account, :only => :show
  
  def index    
    @accounts = current_user.accounts
  end
  
  def show
    
    sort = params[:sort]
    
    if sort.nil? || sort == "time"
      @withdrawals = @account.withdrawals.all(:order => 'created_at DESC')
    else
      @withdrawals = @account.withdrawals.all(:order => 'amount ASC')
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
protected 

  def authorize_account
    @account = Account.find(params[:id])  
    redirect_to accounts_path unless current_user.accounts.exists?(@account)
  end

end
