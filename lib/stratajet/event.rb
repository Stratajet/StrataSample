module Stratajet
  class Event
    attr_accessor :departure_time, :arrival_time, :from_airfield_id, :to_airfield_id, :aircraft_id, :utilization, :utilization_count
    
    def initialize(event_hash)
      @departure_time = event_hash["departure_time"]
      @arrival_time = event_hash["arrival_time"]
      @from_airfield_id = event_hash["from_airfield_id"]
      @to_airfield_id = event_hash["to_airfield_id"]
      @aircraft_id = event_hash["aircraft_id"]
      @utilization = event_hash["utilization"]
      @utilization_count = event_hash["utilization_count"]
      @id = event_hash["id"]
    end
    
    def to_send
      hash = []
      instance_variables.each do |iv|
        hash[iv.to_s] = iv.instance_variable_get(iv)
      end
    end
  end
end

class Awesome
  def initialize
    @abc = 1
    @bcd = 2
  end
end