class TicketsController < ApplicationController
  before_action :current_user
  before_action :user_tickets, only: %i[show]

  def index; end

  def show; end

  def new
    return unless @user.nil?

    flash.alert = 'Please login to checkout tickets'
    redirect_to controller: 'home', action: 'login'
  end

  def create
    amounts = params[:amounts].values
    events = params[:events].values

    return respond_to { |format| format.html { render 'new', status: :conflict } } if amounts.length != events.length

    events.each_with_index do |event_id, i|
      Ticket.create(event_id: event_id, user_id: session[:user_id], amount: amounts[i])
      session[:saved_events].reject! do |event|
        event['id'] == event_id.to_i
      end
    end

    respond_to { |format| format.html { redirect_to '/users/show' } }
  end

  def current_user
    id = session[:user_id]
    @user = User.find_by(id: id)
  end

  def user_tickets
    @tickets = @user.tickets.find(@user.id)
  end
end
