class UsersController < ApplicationController 
# before_filter :require_admin


  # GET /users
  def index
    if session[:current_user_admin].nil?
      redirect_to ideas_url
    end
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if @user.id != session[:current_user_authenticated]
      flash[:error] = 'You can not edit this user.' 
      redirect_to :back
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, notice: 'User was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    if @user.id != session[:current_user_authenticated]
      flash[:error] = 'You can not edit this user.' 
      redirect_to :back
    end

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit" 
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    if @user.id != session[:current_user_authenticated]
      flash[:error] = 'You can not edit this user.' 
      redirect_to :back
    end
    @user.destroy
    redirect_to users_url
  end
end
