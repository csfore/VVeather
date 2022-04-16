module main

import os

fn c() ?string {
	return os.config_dir() 
}

fn init() {
	config := c() or {
		eprintln("Error")
		return
	}

	$if linux {
		// Doing the check for if the configuration file exists
		if os.exists('$config/vveather/config.json') == false {
			// Printing something so the user knows something is happening
			println("First time setup, generating a config file in $config/vveather/...\n")

			// Setting up the City ID
			println("Please go to openweathermap.org, lookup your city, then proceed to put your city ID in.\n")
			println("After you do so, note the URL. For example, New York City's url is https://openweathermap.org/city/\e[1;31m5128581\e[0m\n")

			location := '"' + os.input("You may notice a bold, red string, that is the portion you need for this. Please input that now: ") + '"'

			// Setting up the API Key
			println("\n\nGreat! Now you need your API key from openweather\n")
			println("You can use this link: https://home.openweathermap.org/users/sign_up to sign up for the free version\n")
			api_key := '"' + os.input("Once you do that, input your API Key now (I will not see this, all of this is stored locally): ") + '"'

			// Making the vveather directory w/ proper error handling
			os.mkdir_all('$config/vveather/') or {
				println("Couldn't make the directory")
				return
			}

			// Creating the config.json file
			os.create('$config/vveather/config.json') or {
				println("Couldn't make the settings file")
				return
			}
			
			// Finally, writing to the config.json file after the user inputs their info
			os.write_file("$config/vveather/config.json", '{"location": $location, "api_key": $api_key}') or {
				println("Couldn't write to config.json")
			}
		}
	} $else $if windows {
		if os.exists('$config\\VVeather\\config.json') == false {
			os.mkdir("$config\\VVeather\\") or {
				eprintln("Error making the VVeather directory on Windows: $err")
				return
			}

			
			// Printing something so the user knows something is happening
			println("First time setup, generating a config file in $config\\VVeather\\...\n")

			// Setting up the City ID
			println("Please go to openweathermap.org, lookup your city, then proceed to put your city ID in.\n")
			println("After you do so, note the URL. For example, New York City's url is https://openweathermap.org/city/\e[1;31m5128581\e[0m\n")

			location := '"' + os.input("You may notice a bold, red string, that is the portion you need for this. Please input that now: ") + '"'

			// Setting up the API Key
			println("\n\nGreat! Now you need your API key from openweather\n")
			println("You can use this link: https://home.openweathermap.org/users/sign_up to sign up for the free version\n")
			api_key := '"' + os.input("Once you do that, input your API Key now (I will not see this, all of this is stored locally): ") + '"'

			// Creating the config.json file
			os.create('$config\\VVeather\\config.json') or {
				println("Couldn't make the settings file")
				return
			}
			
			// Finally, writing to the config.json file after the user inputs their info
			os.write_file("$config\\VVeather\\config.json", '{"location": $location, "api_key": $api_key}') or {
				println("Couldn't write to config.json")
				return
			}
		}
	} $else {
		return "Your OS is currently unsupported"
	}
}