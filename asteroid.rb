class Asteroid
  attr_reader :name, :diameter, :miss_distance

  def initialize(name:, diameter:, miss_distance:)
    @name = name
    @diameter = diameter
    @miss_distance = miss_distance
  end

  def to_s
    diameter_string = diameter.to_s + " ft"
    miss_distance_string = miss_distance.to_s + " ft"
    "|#{name.ljust(20)}|#{diameter_string.ljust(20)}|#{miss_distance_string.ljust(20)}|"
  end
end