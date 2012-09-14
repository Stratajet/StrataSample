module Stratajet
  class Operator
    EVENTS_URL = "/events/"
    
    def initialize(application_id, secret, user_token)
      @connection = Connection.new(application_id, secret, user_token)
    end
    
    def index
      @connection.request(:index).map { |e| Event.new(e) }
    end

    def get(id)
      Event.new(@connection.request(:get, {:id => id}))
    end
    
    def put(event)
      Event.new(@connection.request(:get, {:id => id}))
    end
    
    def destroy(event)
    end
        
  end
end