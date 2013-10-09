require "redis/server/version"
require 'redis'
require 'childprocess'
require 'tempfile'
require 'tmpdir'
require 'redis/server/config'

class Redis::Server

  attr_reader :config, :process

  def initialize config={}
    @config = Redis::Server::Config.new(config)
    @config[:'slave-serve-stale-data'] ||= "no"
    @config[:'daemonize'] ||= "no"
    @config[:'bind'] ||= "127.0.0.1"
    @config[:'port'] ||= "#{find_available_port}"
    @config[:'logfile'] ||= Tempfile.new('redis-server-logfile').path
    @config[:'save'] ||= "900 1"
    @config[:'rdbcompression'] ||= "yes"
    @config[:'dbfilename'] ||= "redis_server.rdb"
    @config[:'dir'] ||= Dir.tmpdir
    @config[:'appendonly'] ||= "no"
    @config[:'appendfsync'] ||= "no"
    @config[:'appendfsync'] ||= "everysec"
    @config[:'no-appendfsync-on-rewrite'] ||= "yes"
  end

  def start
    return if started?
    @process = ChildProcess.new('redis-server','-')
    process.duplex = true
    process.start
    at_exit{
      save
      stop
    }
    process.io.stdin.puts config.to_s
    process.io.stdin.close
    @started = process.alive?
  end

  def start!
    start
    started? or raise "failed to start redis server"
  end

  def save
    connection.save if connection
  end

  def stop
    process.stop if started?
  end

  def connection
    @connection ||= connect if started?
  end

  def connect options={}
    options[:host] ||= config[:bind]
    options[:port] ||= config[:port]
    Redis.new(options)
  end

  def started?
    process && process.alive?
  end

  # copied from  capybara-1.1.2
  def find_available_port
    server = TCPServer.new('127.0.0.1', 0)
    server.addr[1]
  ensure
    server.close if server
  end

end
