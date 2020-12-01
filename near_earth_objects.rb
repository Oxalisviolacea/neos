require 'faraday'
require 'figaro'
require 'pry'
require './asteroid'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', 
  path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def initialize(date)
    @date = date
  end

  def asteroids
    parsed_asteroids_data.map do |asteroid|
      Asteroid.new(
        name: asteroid[:name],
        diameter: asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i,
        miss_distance: asteroid[:close_approach_data][0][:miss_distance][:miles].to_i
      )
    end
  end

  def find_neos_by_date
    {
      asteroid_list: formatted_asteroid_data,
      biggest_asteroid: largest_asteroid_diameter,
      total_number_of_asteroids: total_number_of_asteroids
    }
  end

  def formatted_asteroid_data 
    asteroids.map do |asteroid|
      {
        name: asteroid.name,
        diameter: "#{asteroid.diameter} ft",
        miss_distance: "#{asteroid.miss_distance} miles"
      }
    end
  end

  def largest_asteroid_diameter
    lrg_asteroid = asteroids.max_by do |asteroid|
      asteroid.diameter 
    end
    lrg_asteroid.diameter
  end

  def total_number_of_asteroids
    asteroids.count
  end

  private 

  def parsed_asteroids_data
    response = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
    asteroids_list_data = response.get('/neo/rest/v1/feed')
    JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{@date}"]
  end
end
