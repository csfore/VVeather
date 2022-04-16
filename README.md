# VVeather

Welcome to VVeather, a CLI weather app written in V.

## Building

You can just build this with the normal V compiler, V 0.2.4 b72a2de.

## Running

*Note this only runs on Linux until I can add the checks for Windows and Darwin*

To run this, you just make the binary executable with `chmod +x` or any other method then run it like `./vveather`

## Support

If you experience any issues, I'll be happy to take a look at it in [Issues](https://gitlab.com/csfore/vveather/-/issues/new).

## Roadmap

- [x] Utilize a cli-based app to retreive weather information at the user's will

- [ ] Utilize openweathermap's API to make calls and retreive weather info every minute into a crontab task

- [ ] Make /dev/weather/* to cat for the weather

- [ ]  Add force update?