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

  def login
    puts params
    @clientID = '448230211329-av45bn73jaatccunbrm0gl51m54viu5n.apps.googleusercontent.com'
  end

  def create
    puts params
  end
end
