require "pry"
require "rest-client"
require "json"

class WeatherApiWrapper
  BASE_URL = "https://api.weather.gov/"

  def get_grid(lat:, long:)
    response = RestClient.get("#{BASE_URL}/points/#{lat},#{long}")
    response_hash = JSON.parse(response)

    response_hash["properties"].slice("gridId", "gridX", "gridY", "forecast").transform_keys!(&:to_sym)
  end
end
