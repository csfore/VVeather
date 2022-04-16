import os

fn main() {
	home_dir := os.home_dir()
	if os.exists('$home_dir/.config/vveather/config.json') == false {
		println("First time setup, generating a config file in $home_dir/.config/vveather/...\n")
		println("Please go to openweathermap.org, lookup your city, then proceed to put your city ID in.\n")
		println("After you do so, note the URL. For example, New York City's url is https://openweathermap.org/city/\e[1;31m5128581\e[0m\n")

		location := os.input("You may notice a bold, red string, that is the portion you need for this. Please input that now: ")

		println("\n\nGreat! Now you need your API key from openweather\n")
		println("You can use this link: https://home.openweathermap.org/users/sign_up to sign up for the free version\n")
		api_key := os.input("Once you do that, input your API Key now (I will not see this, all of this is stored locally): ")

		os.mkdir_all('$home_dir/.config/vveather/')?
		os.write_file("$home_dir/.config/vvweather/config.json", '{"location": $location, "api_key": $api_key}')
	} else {
		println("Exists")
	}
}