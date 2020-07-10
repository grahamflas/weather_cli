Wednesday Weather
=================

Overview
--------

---

Wednesday Weather is a Ruby command line application that returns a text file containing comma-separated forecasted temperatures for Wednesday night for a given list of locations. 

Forecasted temperatures are obtained using the [National Weather Service (NWS) API](https://www.weather.gov/documentation/services-web-api). 

Geographic coordinates for provided locations should be stored in a local text file in decimal-degree format. Each location should be on a separate line: 

`​38.9072° N, 77.0369° W`

Usage
-----

---

To use the application, run `​bin/wednesday_weather.rb`​ from the command line, providing the local text file containg a list of locations as an argument.

For example, from this project’s directory, using the `​locations.txt`​ file saved in the project's top-level, please run:

```sh
ruby bin/wednesday_weather.rb locations.txt
```

Required gems
-------------

---

Please ensure the following gems are installed:

```sh
gem install rest-client
gem install json
```