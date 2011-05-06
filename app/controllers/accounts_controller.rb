class AccountsController < ApplicationController
  before_filter :authorize
  
  def index    
    @current_user = current_user
    @accounts = current_user.accounts.sort{|x, y| x.id <=> y.id}
  end
  
  def show
    @account = Account.find(params[:id])  
    
    unless current_user.accounts.include?(@account)
      redirect_to root_path 
      return
    end
    
    sort = params[:sort]
    
    if sort.nil? || sort == "time"
      @withdrawals = @account.withdrawals.sort {|x, y| y.created_at <=> x.created_at}
    else
      @withdrawals = @account.withdrawals.sort {|x, y| x.amount <=> y.amount}
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end

end
