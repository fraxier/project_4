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

  def login
    @client_id = '448230211329-av45bn73jaatccunbrm0gl51m54viu5n.apps.googleusercontent.com'
  end

  def create
    # how to validate google token
    # -check first the Cross Site Request Forgery token.
    # - google uses the double-submit-cookie pattern
    # - we have to check the token is the same in both the POST request and the cookie body

    g_csrf_param = params.require(:g_csrf_token)
    g_csrf_cookie = cookies[:g_csrf_token]

    if g_csrf_param.nil? || g_csrf_cookie.nil? ||
       g_csrf_param != g_csrf_cookie
      flash.alert = 'Unable to validate cross site request forgery token'
      render action: login_url
    end

    # 2nd step:
    # id token is properly signed
    # https://www.googleapis.com/oauth2/v3/certs

    url = 'https://www.googleapis.com/oauth2/v3/certs'
    response = HTTParty.get(url)
    response.parsed_response

    kids = response.parsed_response['keys'].map do |key|
      key['kid']
    end

    token = params.require(:credential)
    decoded_token = JWT.decode token, nil, false

    unless kids.include? decoded_token[1]['kid']
      flash.alert = 'Unable to validate token id'
      render action: login_url
    end

    # 3rd step:
    # check aud is equal to app client_id
    unless decoded_token[0]['aud'] == @client_id
      flash.alert = 'Unable to validate client app id'
      render action: login_url
    end

    # 4th step:
    # check iss is either  accounts.google.com or https://accounts.google.com
    unless %w[accounts.google.com https://accounts.google.com].include? decoded_token[0]['iss']
      flash.alert = 'Unable to validate iss'
      render action: login_url
    end

    # 5th step:
    # check expiry time

    unless decoded_token[0]['exp'] >= Time.now.tv_sec
      flash.alert = 'Verification token has expired'
      render action: login_url
    end

    # 6th step:
    # create user then redirect to user account page

    user_id = create_user(
      decoded_token[0]['email'],
      decoded_token[0]['given_name']
    )

    render action: user_

    binding.pry
  end

  def create_user(email, firstname)
    # User.create  
  end
end
