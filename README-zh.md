# Gwitch

Gwitch 可以获取任天堂 Switch 上的所有游戏信息，包括价格查询以及查询开通了 e-shop 的国家。

[Readme](README.md) | [RubyGem](https://rubygems.org/gems/gwitch)

## 依赖

* ruby >= 2.3

## 安装

```bash
gem install gwitch
```

如果使用 Rails，则可以通过 Bundler 安装。在应用的 Gemfile 中添加：

```ruby
gem 'gwitch'
```

然后执行：

    $ bundle

## 基本用法

### Bash

```
Usage: gwitch [options]
    -g, --games                      Get all games (without price info)
    -p, --price alpha2,nsuid1,nsuid2 Get games' price (Max 50 nsuids)
    -c, --countries                  Get avaliable countries' alpha2 code
    -v, --version                    Print version and exit
    -h, --help                       Show help
```

所有返回数据都是 JSON 格式。

可以和 Linux 管道以及重定向一起使用。

比如：

```bash
gwitch -g >> games.json
```

### Ruby

```ruby
require 'gwitch'
```

获取所有游戏。

```ruby
games = Gwitch::Game.all
```

获取所有开通了 e-shop 的国家。

```ruby
countries = Gwitch::Country.all
```

获取国家信息。

```ruby
country = countries.first
country.alpha2     # => 'US'
country.region     # => 'Americas'
country.currency   # => 'USD'
country.avaliable? # => true
```

查询游戏价格（最多同时查询 50 个）。

```ruby
prices = Gwitch::Game.price('US', 'en', '70010000000141,70010000000142')

prices = Gwitch::Game.price('US', 'en', ['70010000000141', '70010000000142'])

prices = Gwitch::Game.price('US', 'en', [70010000000141, 70010000000142])
```

## 编译

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