module Stratajet
  class Connection
    HOST = http://testbed.stratafleet.com/
    EVENTS_URL = "/events/"
    
    def initialize(application_id, secret, user_token)
      @token = token
      @client = OAuth2::Client.new(app_id, secret, site: HOST)
       = OAuth2::AccessToken.new(@client, token, {:refresh_token => @token})
    end
    
    def request(method, o = {})
      case method
      when :index
        @access.get(EVENTS_URL).parsed
      when :get
        @access.get("#{EVENTS_URL}#{o[:id]}").parsed
      when :put
        @access.put("#{EVENTS_URL}#{o[:id]}").parsed
      end
      
    
    
  end
end