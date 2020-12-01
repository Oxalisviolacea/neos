require_relative 'near_earth_objects'

class UserInterface
  def initialize
    @date = ''
  end

  def start
    welcome_message
    get_date
    near_earth_objects
    output
  end

  def welcome_message
    puts welcome_heredoc
  end

  def welcome_heredoc
    <<~HEREDOC
    ________________________________________________________________________________________________________________________________
    Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. 
    Enter a date below to get a list of the objects that have passed by the earth on that day.
    Please enter a date in the following format YYYY-MM-DD.
    >>
    HEREDOC
  end

  def get_date
    @date = gets.chomp
  end

  def near_earth_objects
    neos = NearEarthObjects.new(@date)
    neos.find_neos_by_date
  end

  def asteroids
    neos = NearEarthObjects.new(@date)
    neos.asteroids
  end

  def table_header
    "+#{"Name".center(20)}+#{"Diameter".center(20)}+#{"Miss Distance".center(20)}+"
  end

  def output
    formated_date = DateTime.parse(@date).strftime("%A %b %d, %Y")
    puts "______________________________________________________________________________"
    puts "On #{formated_date}, there were #{near_earth_objects[:total_number_of_asteroids]} objects that almost collided with the earth."
    puts "The largest of these was #{near_earth_objects[:biggest_asteroid]} ft. in diameter."
    puts "\nHere is a list of objects with details:"
    puts table_header
    asteroids.each do |asteroid|
      puts asteroid.to_s
    end
  end
end