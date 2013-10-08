require_relative 'service/endpoint'
require 'enigma/etcd'

class Enigma
  class Service
    include Enigma::Etcd

    attr_accessor :role, :status
    def initialize(name, environment, connection)
      @name = name
      @connection = connection
      @base_path = "/#{environment}/services/#{name}/"
    end

    def service_exists?
      query(@connection, @base_path)
    end

    def has_master?
      if service_exists?
        @endpoints.each do |endpoint|
          if endpoint.role == 'master'
            true
            break
          end
        end
      else
        false
      end
    end

    # return ip of master
    def masters
      m = []
      if self.has_master?
        @endpoints.each do |endpoint|
          if endpoint.role == 'master'
            m.push endpoint.ip
          end
        end
      end
      m
    end

    def endpoints
      ep = query(@connection, @base_path + 'endpoints')
      if ep.nil?
        []
      else
        ep.each do |endpoint|
          ep.push endpoint
        end
      end
    end

    def endpoint(ip, port)
      resp = query(@connection, @base_path + "endpoints/#{ip}")

      role = 'master'
      if resp.nil?
        if has_master?
          role = 'slave'
        end
      else
        info = hashify(resp)
        role = info['role']
        s = info['status']
      end
      ep = Enigma::Service::Endpoint.new(ip, port, role)
      ep.status = s
      ep
    end

    def save_endpoint(endpoint)
      path = @base_path + "endpoints/#{endpoint.ip}/"
      write(@connection, path + "port", endpoint.port)
      write(@connection, path + "role", endpoint.role)
      unless endpoint.status.nil?
        write(@connection, path + "status", endpoint.status)
      end
    end
  end
end
