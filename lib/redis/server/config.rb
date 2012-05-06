class Redis::Server::Config < Hash

  def initialize hash
    hash.each{|k,v| self[k] = v}
  end

  def to_s
    map{|p| p.join(' ')}.join("\n")
  end
  alias_method :inspect, :to_s

end
