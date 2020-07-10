Wednesday Weather
=================

Overview
--------


Wednesday Weather is a Ruby command line application that returns a text file containing comma-separated forecasted temperatures for Wednesday night for a given list of locations. 

Forecasted temperatures are obtained using the [National Weather Service (NWS) API](https://www.weather.gov/documentation/services-web-api). 

Geographic coordinates for provided locations should be stored in a local text file in decimal-degree format. Each coordinates for each location should be on a separate line: 

`​38.9072° N, 77.0369° W`

Usage
-----


To use the application, run `​bin/wednesday_weather.rb`​ from the command line, providing as an argument the local text file containing a coordinates for desired locations.

For example, from this project’s root, using the provided `​locations.txt`​ file, please run:

```sh
ruby bin/wednesday_weather.rb locations.txt
```

Required gems
-------------


Please ensure the following gems are installed:

```sh
gem install rest-client
gem install json
```
