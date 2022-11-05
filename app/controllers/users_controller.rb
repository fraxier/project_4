require 'pry'

class UsersController < ApplicationController
  def show
    
    if session[:user_id].nil?
      flash.alert = 'Please login to view that page'
      render action: 'home/login' and return
    end
    @user = User.find_by(id: session[:user_id])
  end

  def new; end

  def create
    @user = User.new(user_params)
    @user.is_external_login = false

    respond_to do |format|
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_url(@user), notice: 'Account successfully created' }
      else

        format.html { render :new, status: :bad_request }
      end
    end
  end

  def user_params
    params.permit(:username, :email, :password)
  end
end
