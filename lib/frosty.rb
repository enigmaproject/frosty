require 'frosty/service'
require 'frosty/node'
require 'frosty/etcd'
require 'etcd'

class Frosty
  include Frosty::Etcd

  attr_accessor :environment, :server, :port
  def initialize(server = '127.0.0.1', port = '4001', options ={})
    @server = server
    @port = port
    @environment = options['environment'] || 'default'
  end

  def can_connect?
    connect
    ret = true
    begin
      @connection.get('/')
    rescue
      ret = false
    end
    ret
  end

  def connect
    @connection = ::Etcd.client(:host => @server,
                               :port => @port)
  end

  def services
    array_of_keys("/#{@environment}/services/")
  end

  def nodes
    array_of_keys("/#{@environment}/nodes/")
  end

  # This probably needs to be re-worked
  def array_of_keys(key)
    n = query(@connection, key)
    if n.nil?
      []
    else
      a = []
      n.each do |value|
        a.push(value.key.gsub(key, ''))
      end
      a
    end
  end

  def service(name)
    Frosty::Service.new(name, @environment, @connection)
  end

  def node(name)
    Frosty::Node.new(name, @environment, @connection)
  end
end
