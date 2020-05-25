# Gwitch

Gwitch can get switch games info (including price) from nintendo official API.

## Prerequisites

* ruby >= 2.3

## Installation

```bash
gem install gwitch
```

Or you can install via Bundler if you are using Rails. Add this line to your application's Gemfile:

```ruby
gem 'gwitch'
```

And then execute:

    $ bundle

## Basic Usage

### Bash

```
Usage: gwitch [options]
    -g, --games                      Get all games (without price info)
    -p, --price alpha2,nsuid1,nsuid2 Get games' price (Max 50 nsuids)
    -c, --countries                  Get avaliable countries' alpha2 code
    -v, --version                    Print version and exit
    -h, --help                       Show help
```

The returned data will always be in json format.

Can be used with pipes and redirects.

eg.

```bash
gwitch -g >> games.json
```

### Ruby

```ruby
require 'gwitch'
```

Get all games.

```ruby
games = Gwitch::Game.all
```

Get all avaliable countries.

```ruby
countries = Gwitch::Country.all
```

Get country's info.

```ruby
country = countries.first
country.alpha2     # => 'US'
country.region     # => 'Americas'
country.currency   # => 'USD'
country.avaliable? # => true
```

Query games' price (Max 50 games).

```ruby
prices = Gwitch::Game.price('US', 'en', '70010000000141,70010000000142')
```

## Build

```bash
git clone https://github.com/Dounx/gwitch
cd gwitch
gem build gwitch.gemspec
gem install --local gwitch-*.gem
```

## Rake

List of available tasks

```bash
rake --tasks
```

## License

Gwitch is an open-sourced software licensed under the [MIT license](LICENSE).