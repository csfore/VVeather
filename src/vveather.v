package main

import net.http
import json
import os

struct Foo {
	x int
}

struct WeatherInfo {
	id int
	main string
	description string

}

struct WeatherMain {
	temp int
	feels_like int
	temp_min int
	temp_max int
	pressure int
	humidity int

}

struct WeatherWind {
	speed int
	deg int
}

struct WeatherSys {
	country string
	sunrise int
	sunset int
}

struct Weather {
	weather []WeatherInfo
	main WeatherMain
	wind WeatherWind
	visibility int
	timezone int
	name string
	sys WeatherSys
}

fn main() {
	req_url := "https://api.openweathermap.org/data/2.5/weather?id=CITY_ID&units=imperial&appid=API_KEY"
	data := http.get_text(req_url)

	weather := json.decode(Weather, data) or {
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
		println(data)
	} else {
		println("Weather info for \e[0;34m$location \e[0m")
		println("The current temperature is: $temp° F")
		println("Wind Speed is: $wind_speed mph")
		println("It is currently $humidity% humid")
		println("\n\nFor help, use -h or --help")
	}
}