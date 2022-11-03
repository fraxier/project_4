class ApplicationController < ActionController::Base
  include ActionController::Cookies
  protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
end
