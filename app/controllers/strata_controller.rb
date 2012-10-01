class StrataController < ApplicationController
  APP_ID = "dc1614e4f5038942aff26fb0abc79a5cb7cba2a5d664ea4ddcd935068e6a91a6"
  SECRET = "35344a52cd09c44c8fe9b9408ef0dfd57fe21e4fb4a55cdb2a083e8cbc6f50eb"
  CALLBACK = "http://localhost:3000/callback"
  SITE = "http://testbed.stratafleet.com/"
  
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
    operator = StrataGem::Operator.new(APP_ID, SECRET, session[:token], false)
    @events = operator.index
  end

  
  protected
  def client
    OAuth2::Client.new(APP_ID, SECRET, site: SITE)
  end
end
