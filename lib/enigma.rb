require 'enigma/service'
require 'enigma/node'
require 'enigma/etcd'
require 'etcd'

class Enigma
  include Enigma::Etcd

  attr_accessor :environment
  def initialize(server, port, options ={})
    @server = server
    @port = port
    @connection = connect
    @environment = options['environment'] || 'default'
  end

  def connect
    connection = ::Etcd.client(:host => @server,
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
    Enigma::Service.new(name, @environment, @connection)
  end

  def node(name)
    # should return a new node object
  end
end
