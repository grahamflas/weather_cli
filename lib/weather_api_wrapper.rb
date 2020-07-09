require "pry"
require "rest-client"
require "json"

class WeatherApiWrapper
  BASE_URL = "https://api.weather.gov/"

  def get_grid(lat:, long:)
    response = RestClient.get("#{BASE_URL}/points/#{lat},#{long}")
    response_hash = JSON.parse(response)

    grid_and_office = response_hash["properties"].slice("gridId", "gridX", "gridY").transform_keys!(&:to_sym)
    city_state = response_hash["properties"]["relativeLocation"]["properties"].slice("city", "state").transform_keys!(&:to_sym)
    
    grid_and_office.merge(city_state)
  end

  def get_forecast(gridId:, gridX:, gridY:)
    response = RestClient.get(
      "#{BASE_URL}/gridpoints/#{gridId}/#{gridX},#{gridY}/forecast"
    )
    response_hash = JSON.parse(response)
    response_hash["properties"]["periods"]
  end
end
 