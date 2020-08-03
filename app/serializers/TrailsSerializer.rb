class TrailsSerializer
  include FastJsonapi::ObjectSerializer
  has_many :trails
  attributes :id, :location, :forecast
end
