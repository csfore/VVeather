// This file is named _weather so I don't get confused

module main


// These structs are upside-down because they don't work from the main Weather struct, down for some reason


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