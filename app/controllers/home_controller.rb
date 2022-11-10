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
