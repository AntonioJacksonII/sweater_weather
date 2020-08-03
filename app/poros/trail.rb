class Trail
  attr_reader :name,
              :summary,
              :difficulty,
              :location,
              :distance_to_trail

  def initialize(trail_info)
    @name = trail_info[:name]
    @summary = trail_info[:summary]
    @difficulty = trail_info[:difficulty]
    @location = trail_info[:location]
    @latitute = trail_info[:latitude]
    @longitude = trail_info[:longitude]
  end

  def distance_to_trail

  end
end
