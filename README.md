## NOTE: DON'T use this gem for now, It should be released next week.


## Gwitch

A gem can get switch games info from nintendo official API.

### PREREQUISITES

* ruby >= 2.3

### BUILD

```bash
git clone https://github.com/Dounx/gwitch
cd gwitch
gem build gwitch.gemspec
gem install --local gwitch-0.0.1.gem
```

### USAGE

```ruby
require 'gwitch'

games = Gwitch::Game.all
price = Gwitch::Game.price('US', 'en', '70010000000141')
```

### To Do List

* More image link

### LICENSE

Gwitch is an open-sourced software licensed under the [MIT license](LICENSE.md).