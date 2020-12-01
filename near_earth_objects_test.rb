require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def setup
    near_earth_objects = NearEarthObjects.new('2019-03-30')
    @results = near_earth_objects.find_neos_by_date
  end
  def test_a_date_returns_a_list_of_neos
    assert_equal '(2011 GE3)', @results[:asteroid_list][0][:name]
  end

  def test_find_the_largest_asteroid
    assert_equal 537, @results[:biggest_asteroid]
  end

  def test_find_the_total_number_of_asteroids
    assert_equal 10, @results[:total_number_of_asteroids]
  end
end
