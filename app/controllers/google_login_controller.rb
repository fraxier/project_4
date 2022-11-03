class GoogleLoginController < ApplicationController
  def create
    token = params.require(:credential)
    decoded_token = JWT.decode token, nil, false

    check_msg = super_check(
      param: params.require(:g_csrf_token),
      cookie: cookies[:g_csrf_token],
      kid: decoded_token[1]['kid'],
      aud: decoded_token[0]['aud'],
      iss: decoded_token[0]['iss'],
      exp: decoded_token[0]['exp']
    )

    if check_msg == 'passed'
      create_user(decoded_token[0]['email'], decoded_token[0]['given_name'])
    else
      render_login_alert! check_msg
    end
  end

  def super_check(param:, cookie:, kid:, aud:, iss:, exp:)
    return 'Unable to validate cross site request forgery token' unless check_csrf(param, cookie)

    return 'Unable to validate token id' unless check_signature(kid)

    return 'Unable to validate client app id' unless check_aud(aud)

    return 'Unable to validate iss' unless check_iss(iss)

    return 'Verification token has expired' unless check_not_expired(exp)

    'passed'
  end

  def render_login_alert!(msg)
    flash.alert = msg
    render action: 'login' and return # prevents further execution in the create method?
  end

  def create_user(email, firstname)
    user = User.find_by({ email: email, username: firstname })

    if user.nil?
      user = User.create({ email: email, username: firstname })
      flash.notice = "Successfully logged in as #{user.username}"
    else
      flash.notice = 'Account successfully created'
    end

    session[:user_id] = user.id
    redirect_to '/users'
  end

  def check_csrf(param, cookie)
    return false if param.nil? || cookie.nil? || param != cookie

    true
  end

  def check_signature(kid)
    url = 'https://www.googleapis.com/oauth2/v3/certs'
    response = HTTParty.get(url)
    response.parsed_response

    kids = response.parsed_response['keys'].map do |key|
      key['kid']
    end

    kids.include? kid
  end

  def check_aud(aud)
    @client_id = '448230211329-av45bn73jaatccunbrm0gl51m54viu5n.apps.googleusercontent.com'
    aud == @client_id
  end

  def check_iss(iss)
    %w[accounts.google.com https://accounts.google.com].include? iss
  end

  def check_not_expired(exp)
    exp > Time.now.tv_sec
  end

  # how to validate google token
  # 1st step:
  # check first the Cross Site Request Forgery token.
  # google uses the double-submit-cookie pattern
  # we have to check the token is the same in both the POST request and the cookie body
  # 2nd step:
  # id token is properly signed
  # https://www.googleapis.com/oauth2/v3/certs
  # 3rd step:
  # check aud is equal to app client_id
  # 4th step:
  # check iss is either  accounts.google.com or https://accounts.google.com
  # 5th step:
  # check expiry time
end
