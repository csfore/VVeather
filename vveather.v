/*  
    Name: Christopher Fore
    GitLab: https://gitlab.com/csfore/vveather
    Description: Simple CLI app written in V to display the weather for the user-given location
	License: GNU AGPL v3

*/

module main

import net.http
import json
import os

// The function used to read the config.json file
fn f() ?string {
	home_dir := os.home_dir()
	file := os.read_file("$home_dir/.config/vveather/config.json")?
	return file
}

fn main() {
	init()
	raw_file := f()?

	// Decoding the config.json file into the info variable w/ proper error handling
	info := json.decode(Settings, raw_file) or {
		eprintln("Failed to decode json, line 28, error: $err")
		return
	}

	// Defining the City ID and API Key variables to use in the URL
	location_url := info.location
	api_key_url := info.api_key
	req_url := "https://api.openweathermap.org/data/2.5/weather?id=$location_url&units=imperial&appid=$api_key_url"

	// Raw JSON from the request
	raw_http := http.get_text(req_url)

	// Decoding the web request from the API
	weather := json.decode(Weather, raw_http) or {
		eprintln("Failed to decode json, line 37, error: $err")
		return
	}

	// Variables for the Weather struct
	visibility := weather.visibility
	location := weather.name

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
	description := weather.weather[0].description


	// Defining the CLI arguments with a help menu and such
	if '-h' in os.args || '--help' in os.args {
		// Help Menu
		println("Usage: weather [options]")
		println(" -v, --verbose          Outputs all available information on the weather")
		println(" -h, --help             Displays the help menu")
		println(" -r, --raw              Displays raw JSON")
	} else if '-v' in os.args || '--verbose' in os.args {
		// Verbose Output
		//    General Weather Info
		println("Weather info for \e[0;34m$location \e[0m")
		println("The current weather is $description")
		println("The current temperature is: $temp° F")
		println("It feels like $feels_like° F")
		println("The minimum is $temp_min° F")
		println("The maximum temp is $temp_max° F\n")

		//    Wind Info
		println("Wind Speed is: $wind_speed mph")
		println("Wind is moving at $wind_deg degrees\n")

		//    Misc. Weather Info
		println("It is currently $humidity% humid")
		println("Visibility is $visibility meters")
		println("Current pressure is $pressure hPa")
	} else if '-r' in os.args || '--raw' in os.args {
		// Raw JSON output from the URL
		println(raw_http)
	} else {
		// General Info most users need, with terminal formatting (Might add more later)
		println("Weather info for \e[0;34m$location \e[0m")
		println("The current temperature is: $temp° F")
		println("Wind Speed is: $wind_speed mph")
		println("It is currently $humidity% humid")
		println("\n\nFor help, use -h or --help")
	}
}