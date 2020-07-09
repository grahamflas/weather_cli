require "pry"
  
class WeatherCLI
  attr_accessor :raw_locations, :locations

  def initialize
    @raw_locations = []
    @locations = []
    @api_wrapper = WeatherApiWrapper.new
  end

  def run
    read_locations
    self.locations = to_lat_long(raw_locations)
    add_grid_office_to_locations_hash
    add_forecast_to_locations_hash
    binding.pry
  end

  def read_locations
    File.foreach(ARGV.first) {|line| self.raw_locations << line.chomp }
  end

  def to_lat_long(raw_locations)
    self.raw_locations.map do |location|
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

  def add_grid_office_to_locations_hash
    self.locations.map! do |location|
      office_and_grid_hash = @api_wrapper.get_grid(
        lat: location[:lat], 
        long: location[:long],
      )
      
      location.merge(office_and_grid_hash)
    end
  end

  def add_forecast_to_locations_hash
    self.locations.map! do |location|
      forecast_array = @api_wrapper.get_forecast(
        gridId: location[:gridId],
        gridX: location[:gridX],
        gridY: location[:gridY],
      )
      
      forecast_array.each {|el| el.transform_keys!(&:to_sym)}
      
      location.merge({:forecast_details => forecast_array})
    end
  end

end
