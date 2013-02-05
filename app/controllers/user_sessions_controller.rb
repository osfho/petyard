class UserSessionsController < ApplicationController
  before_filter :require_login, :only => :destroy

  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password],params[:remember])
        format.html { redirect_back_or_to(@user) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash[:login_error] = "Incorrect username and/or password."; redirect_to login_path }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    logout
    redirect_to(root_url)
  end
end
