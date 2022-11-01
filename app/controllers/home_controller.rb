class HomeController < ApplicationController
  def index
    # needs to get 6 upcoming concerts orrrr can make other methods that are mapped to other routes :o
  end

  def upcoming
  end

  def headliners
    Events.headliners
  end
end
