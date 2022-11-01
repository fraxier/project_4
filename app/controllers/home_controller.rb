class HomeController < ApplicationController
  def index
    # needs to get stuff orrrr can make other methods that are mapped to other routes :o hmm too much work at the moment lol
    @data = { upcoming: upcoming, headliners: headliners }
  end

  def upcoming
    Event.upcoming 6
  end

  def headliners
    Event.headliners
  end
end
