# Simple::Redis::Server

starts a redis server

## Installation

Add this line to your application's Gemfile:

    gem 'simple-redis-server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple-redis-server

## Usage

require 'redis/server'
s = Redis::Server.new
s.start
s.connect.set(:foo,:bar)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
