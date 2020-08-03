class Trail
  attr_reader :name,
              :summary,
              :difficulty,
              :location

  def initialize(trail_info)
    @name = trail_info[:name]
    @summary = trail_info[:summary]
    @difficulty = trail_info[:difficulty]
    @location = trail_info[:location]
  end

  def distance_to_trail
    
  end
end
