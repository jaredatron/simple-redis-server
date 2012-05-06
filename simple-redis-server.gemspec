# -*- encoding: utf-8 -*-
require File.expand_path('../lib/redis/server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jared Grippe"]
  gem.email         = ["jared@deadlyicon.com"]
  gem.description   = %q{starts a redis server}
  gem.summary       = %q{starts a redis server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simple-redis-server"
  gem.require_paths = ["lib"]
  gem.version       = Redis::Server::VERSION

  gem.add_runtime_dependency "redis"
  gem.add_runtime_dependency "childprocess"
end
