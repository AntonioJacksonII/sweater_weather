class TrailSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :summary, :difficulty, :location
end
