require "pry"
  
class WeatherCLI
  def initialize
    @locations = []
  end

  def run
    read_locations
    #delete locations_array after you figure out what to do with each coordinate
    locations_array = locations_to_lat_long_hash
    binding.pry
  end

  def read_locations
    File.foreach(ARGV.first) {|line| @locations << line.chomp }
  end

  def locations_to_lat_long_hash
    @locations.map do |location|
      coordinates = location.split(",").each {|coordinate| coordinate.strip!}

      coordinates_hash = {}
      coordinates_hash[:lat] = clean_coordinates(coordinates.first)
      coordinates_hash[:long] = clean_coordinates(coordinates.last)
  
      coordinates_hash
    end
  end

  def clean_coordinates(coordinate)
    clean_coordinate = coordinate[0..6]
    
    if coordinate.end_with?("S", "s", "W", "w")
      clean_coordinate.prepend("-") 
    end
    
    clean_coordinate
  end

end
