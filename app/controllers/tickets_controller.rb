class TicketsController < ApplicationController
  before_action :current_user
  before_action :user_tickets, only: %i[show]

  def show; end

  def new
    return unless @user.nil?

    flash.alert = 'Please login to checkout tickets'
    redirect_to controller: 'home', action: 'login'
  end

  def create
    
  end

  def current_user
    id = session[:user_id]
    @user = User.find_by(id: id)
  end

  def user_tickets
    @tickets = @user.tickets.find(@user.id)
  end
end
