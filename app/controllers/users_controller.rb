class UsersController < ApplicationController
  before_filter(:only => [:edit, :update, :remove_avatar]) { |b| b.require_power 0 }
  before_filter(:only => [:index, :destroy]) { |b| b.require_power 5 }
  before_filter :find_players_online

  # GET /users
  # GET /users.json
  def index
    @ranks = Rank.includes(:users).order('power asc').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if !params[:id]
      @user = current_user
    else
      @user = User.find_by_username(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if !logged_in? or current_user.has_power(4)
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to account_path
    end
  end

  # GET /users/1/edit
  def edit
    if !current_user.has_power(5) or !params[:id]
      @user = current_user
    else
      @user = User.find_by_username(params[:id])
    end
    @ranks = Rank.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to notify_path, notice: "Your account has been created. However, you must verify your account with an administrator to complete activation. You may do so by connecting to <span class='highlight'>petyard.net</span> in Minecraft.<br /><br /><a href='#{user_path(@user)}'>Continue to your profile</a>" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = "Account updated."
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find_by_username(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def remove_avatar
    @user = User.find_by_username(params[:id])

    if @user == current_user || @user.has_power(4)
      @user.avatar = nil
      @user.save
    end

    redirect_to account_path
  end

  protected

  def find_players_online
    @players_online = get_players_online
  end

end
