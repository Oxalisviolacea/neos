class Asteroid
  attr_reader :name, :diameter, :miss_distance

  def initialize(name:, diameter:, miss_distance:)
    @name = name
    @diameter = diameter
    @miss_distance = miss_distance
  end

  # def formatted_hash
  #         {
  #       name: name,
  #       diameter: "#{distance} ft",
  #        miss_distance: "#{miss_distance} miles"
  #      }
  # end

  # def to_s
  #   "#{name}      | #{distance} ft    | ...."
  # end
end