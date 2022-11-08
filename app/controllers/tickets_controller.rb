class TicketsController < ApplicationController
  before_action :current_user
  before_action :user_tickets, only: %i[show create]

  def show; end

  def create; end

  def new; end

  def current_user
    id = session[:user_id]
    @user = User.find(id)
  end

  def user_tickets
    @tickets = @user.tickets.find(@user.id)
  end
end
