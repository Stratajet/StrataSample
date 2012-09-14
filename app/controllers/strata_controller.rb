class StrataController < ApplicationController
  def index
    callback = "http://localhost:3000/callback/"
    app_id = "1d6c8576fa997b955b0e7d748b08948268e470c1b0969b3909de96a441aa8819"
    secret = "3d6983c395bead24f4cfd3aee74a9001d4e83b80c74bc5500fac48a6cfb888ab"
    client = OAuth2::Client.new(app_id, secret, site: "http://testbed.stratafleet.com/")
    @authorization_url = client.auth_code.authorize_url(redirect_uri: callback)
  end
  
  def callback
    token = params[:code]
    access = client.auth_code.get_token('b77df49142317a6a42ea12412d2065c949c9e01ca3c9d72a478f34f153a88678', redirect_uri: callback)
    access.get("/api/tasks").parsed
    access.post("/api/tasks", params: {task: {name: "test oauth"}})
    access.get("/api/user").parsed
    
  end
end
