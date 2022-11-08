require 'pry'
require 'jwt'
require 'httparty'

class HomeController < ApplicationController
  def index
    # needs to get stuff orrrr can make other methods that are mapped to other routes :o hmm too much work at the moment lol
    puts params
    @data = { upcoming: upcoming, headliners: headliners }
    cookies[:saved_events] = [258] if cookies[:save_events].nil?
  end

  def upcoming
    Event.upcoming 6
  end

  def headliners
    Event.headliners
  end

  def save_event
    event_id = params[:id]
    cookies[:saved_events] << event_id
    respond_to do |format|
      format.json { render json: { events: cookies[:saved_events] } }
    end
  end

  def remove_event
    event_id = params[:id]
    cookies[:saved_events] -= [event_id]
    respond_to do |format|
      format.json { render json: { events: cookies[:saved_events] } }
    end
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
