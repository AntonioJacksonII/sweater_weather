class RoadTrip
  attr_reader :id,
              :travel_time,
              :forecast,
              :origin,
              :destination

  def initialize(travel_time, forecast, origin, destination)
    @id = nil
    @travel_time = travel_time
    @forecast = forecast
    @origin = origin
    @destination = destination
  end
end
