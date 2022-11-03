require 'pry'
require 'jwt'
require 'httparty'

class HomeController < ApplicationController
  def index
    # needs to get stuff orrrr can make other methods that are mapped to other routes :o hmm too much work at the moment lol
    puts params
    @data = { upcoming: upcoming, headliners: headliners }
  end

  def upcoming
    Event.upcoming 6
  end

  def headliners
    Event.headliners
  end

  def login; end

  def logout
    flash.notice = 'You have successfully logged out' if session[:user_id].nil?

    session[:user_id] = nil
    render :login
  end
end
