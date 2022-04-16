module main

import net.http
import json
import os

 fn f() ?string {
	home_dir := os.home_dir()
	file := os.read_file("$home_dir/.config/vveather/config.json")?
	return file
 }

fn main() {
	init()
	//home_dir := os.home_dir()
	raw_file := f()?

	info := json.decode(Settings, raw_file) or {
		eprintln("Failed to decode json, error 1: $err")
		return
	}
	location_url := info.location
	api_key_url := info.api_key
	req_url := "https://api.openweathermap.org/data/2.5/weather?id=$location_url&units=imperial&appid=$api_key_url"
	raw_http := http.get_text(req_url)

	weather := json.decode(Weather, raw_http) or {
		eprintln("Failed to decode json, error: $err")
		return
	}

	// Variables for the Weather struct
	visibility := weather.visibility
	//timezone := weather.timezone
	location := weather.name

	// Variables for WeatherSys struct
	//country := weather.sys.country
	//sunrise := weather.sys.sunrise
	//sunset := weather.sys.sunset

	// Variables for the WeatherWind struct
	wind_speed := weather.wind.speed
	wind_deg := weather.wind.deg
	
	// Variables for the WeatherMain struct
	temp := weather.main.temp
	feels_like := weather.main.feels_like
	temp_min := weather.main.temp_min
	temp_max := weather.main.temp_max
	pressure := weather.main.pressure
	humidity := weather.main.humidity

	// Variables for the WeatherInfo struct
	//id := weather.weather[0].id
	//main := weather.weather[0].main - Unused
	description := weather.weather[0].description



	if '-h' in os.args || '--help' in os.args {
		println("Usage: weather [options]")
		println(" -v, --verbose          Outputs all available information on the weather")
		println(" -h, --help             Displays the help menu")
		println(" -r, --raw              Displays raw JSON")
	} else if '-v' in os.args || '--verbose' in os.args {
		println("Weather info for \e[0;34m$location \e[0m")
		println("The current weather is $description")
		println("The current temperature is: $temp° F")
		println("It feels like $feels_like° F")
		println("The minimum is $temp_min° F")
		println("The maximum temp is $temp_max° F\n")

		println("Wind Speed is: $wind_speed mph")
		println("Wind is moving at $wind_deg degrees\n")


		println("It is currently $humidity% humid")
		println("Visibility is $visibility meters")
		println("Current pressure is $pressure hPa")
	} else if '-r' in os.args || '--raw' in os.args {
		println(raw_http)
	} else {
		println("Weather info for \e[0;34m$location \e[0m")
		println("The current temperature is: $temp° F")
		println("Wind Speed is: $wind_speed mph")
		println("It is currently $humidity% humid")
		println("\n\nFor help, use -h or --help")
	}
}