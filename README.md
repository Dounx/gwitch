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

```ruby
require 'gwitch'
```

Get all games from americas, asia and europe eshops.

```ruby
games = Gwitch::Game.all
```

Get all games from one eshops.

```ruby
# Americas, Asia and Europe
games = Gwitch::Game.all('Americas')
```

Get all avaliable countries.

```ruby
countries = Gwitch::Country.all
```

Get country's info.

```ruby
country = Gwitch::Country.new('US')
country.alpha2   # => 'US'
country.region   # => 'Americas'
country.currency # => 'USD'
```

Query game's price.

```ruby
price = Gwitch::Game.price('US', 'en', '70010000000141')
```

## Build

```bash
git clone https://github.com/Dounx/gwitch
cd gwitch
gem build gwitch.gemspec
gem install --local gwitch-0.0.1.gem
```

## License

Gwitch is an open-sourced software licensed under the [MIT license](LICENSE.md).