class StrataController < ApplicationController
  APP_ID = "1d6c8576fa997b955b0e7d748b08948268e470c1b0969b3909de96a441aa8819"
  SECRET = "3d6983c395bead24f4cfd3aee74a9001d4e83b80c74bc5500fac48a6cfb888ab"
  CALLBACK = "http://localhost:3000/callback"
  
  # This is the main page that generates the url required for authorizing this application
  def index
    @authorization_url = client.auth_code.authorize_url(redirect_uri: CALLBACK, :scope => "developer")
  end
  
  
  # This processes the callback from the testbed that allows us to get a token and store it in our session
  def callback
    if params[:error]
      render :fail
    else
      code = params[:code]
      access = client.auth_code.get_token(code, redirect_uri: CALLBACK)
      @token = access.token
      session[:token] = @token
      render :win
    end
  end
  
  
  # This uses the token to get a list of flights
  def flight_list
    operator = Stratajet::Operator.new(APP_ID, SECRET, session[:access_token])
    @events = operator.index
  end

  
  protected
  def client
    OAuth2::Client.new(APP_ID, SECRET, site: "http://testbed.stratafleet.com/")
  end
end
