module main

import os

fn test_file() {
	home_dir := os.home_dir()
	assert os.exists('$home_dir/.config/vveather/config.json') == true
}

fn test_f() {
	assert f()? 
}