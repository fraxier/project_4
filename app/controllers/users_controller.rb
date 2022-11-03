class UsersController < ApplicationController
  def show
    if session[:user_id].nil?
      flash.alert = 'Please login to view that page'
      render action: 'home/login' and return
    end
    @user = User.find_by(id: session[:user_id])
  end
end
