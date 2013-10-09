require_relative 'service/endpoint'
require 'frosty/etcd'

class Frosty
  class Service
    include Frosty::Etcd

    attr_accessor :role, :status
    def initialize(name, environment, connection)
      @name = name
      @connection = connection
      @base_path = "/#{environment}/services/#{name}/"
      @endpoints = fetch_endpoints
    end

    def exists?
      if query(@connection, @base_path).nil?
        false
      else
        true
      end
    end

    def has_master?
      ret = false
      if self.exists?
        @endpoints.each do |ep|
          if ep.role == 'master'
            ret = true
            break
          end
        end
      end
      ret
    end

    # return ip of master
    def masters
      m = []
      if self.has_master?
        @endpoints.each do |ep|
          if ep.role == 'master'
            m.push ep.ip
          end
        end
      end
      m
    end

    def refresh
      @endpoints = fetch_endpoints
    end

    def fetch_endpoints
      ret = []
      endpoints = query(@connection, @base_path + 'endpoints')
      unless endpoints.nil?
        endpoints.each do |e|
          ret.push endpoint(e.key.split('/').pop)
        end
      end
      ret
    end

    def endpoints
      ret = []
      @endpoints.each do |endpoint|
        ret.push endpoint.ip
      end
      ret
    end

    def endpoint(ip)
      resp = query(@connection, @base_path + "endpoints/#{ip}")

      ep = Frosty::Service::Endpoint.new(ip)
      if resp.nil?
        if has_master?
          ep.role = 'slave'
        else
          ep.role = 'master'
        end
      else
        info = hashify(resp)
        ep.port = info['port']
        ep.role = info['role']
        ep.status = info['status']
      end
      ep
    end

    def save_endpoint(ep)
      if ep.port.nil?
        raise TypeError, "Endpoint port must be either a string or an integer"
      end
      path = @base_path + "endpoints/#{ep.ip}/"
      write(@connection, path + "port", ep.port)
      write(@connection, path + "role", ep.role)
      unless ep.status.nil?
        write(@connection, path + "status", ep.status)
      end
      refresh
    end
  end
end
