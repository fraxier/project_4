require 'pry'
require 'jwt'
require 'httparty'

class HomeController < ApplicationController
  def index
    puts params
    @data = { upcoming: upcoming, headliners: headliners }
    # session[:saved_events] = [Event.last, Event.first]
  end

  def upcoming
    Event.upcoming 6
  end

  def headliners
    Event.headliners
  end

  def pledged_events
    return if session[:user_id].nil?

    @user = User.find(session[:user_id])

    respond_to do |format|
      format.json { render json: @user.tickets }
      format.html { render json: @user.tickets }
    end
  end

  def saved_events
    respond_to do |format|
      format.html { render json: session[:saved_events] }
      format.json { render json: session[:saved_events] }
    end
  end

  def save_event
    session[:saved_events] ||= []
    session[:saved_events] << Event.find(params[:id])
    respond_to do |format|
      format.json { render json: session[:saved_events] }
    end
  end

  def remove_event
    session[:saved_events] ||= []
    session[:saved_events].reject! do |event|
      event['id'] == params[:id].to_i
    end

    respond_to do |format|
      format.json { render json: session[:saved_events] }
    end
  end

  def verify_login
    @user = User.new(user_params)
    @user.username = 'fake'

    respond_to do |format|
      if @user.valid?

        @actual_user = User.find_by(email: @user.email)

        if @actual_user.nil?
          flash.alert = "Could not find account with email: #{@user.email}"
          format.html { render :login, status: :bad_request }
        elsif @actual_user.password != @user.password
          flash.alert = 'Password/Email combination did not match'
          format.html { render :login, status: :bad_request }
        else
          @user = @actual_user
          session[:user_id] = @user.id
          format.html { redirect_to user_url(@user), notice: "Successfully logged in as #{@user.username}" }
        end
      else
        flash.alert = 'Login was invalid'
        format.html { render :login, status: :bad_request }
      end
    end
  end

  def user_params
    params.permit(:username, :email, :password)
  end

  def login
    flash.notice = nil
    flash.alert = 'You are already logged in!' unless session[:user_id].nil?
  end

  def logout
    flash.notice = 'You have successfully logged out' unless session[:user_id].nil?

    session[:user_id] = nil
    render :login
  end
end
