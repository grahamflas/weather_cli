require "pry"
  
class WeatherCLI
  attr_accessor :raw_locations, :locations

  def initialize
    @raw_locations = []
    @locations = []
  end

  def run
    read_locations
    locations = to_lat_long(raw_locations)
    binding.pry
  end

  def read_locations
    File.foreach(ARGV.first) {|line| raw_locations << line.chomp }
  end

  def to_lat_long(raw_locations)
    raw_locations.map do |location|
      coordinates = location.split(",").each {|coordinate| coordinate.strip!}

      coordinates_hash = {}
      coordinates_hash[:lat] = clean_coordinates(coordinates.first)
      coordinates_hash[:long] = clean_coordinates(coordinates.last)
  
      coordinates_hash
    end
  end

  def clean_coordinates(coordinate)
    non_digit_or_dec = coordinate.index(/[^\d|.]/)

    clean_coordinate = coordinate[0...non_digit_or_dec]
    
    if coordinate.end_with?("S", "s", "W", "w")
      clean_coordinate.prepend("-") 
    end

    clean_coordinate
  end

end
