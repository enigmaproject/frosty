require 'enigma/etcd'

class Enigma
  class Node
    include Enigma::Etcd

    def initialize(ip, connection)
      @ip = ip
      @connection = connection
      @base_path = "/#{environment}/services/#{ip}/"
      @services
    end

    def exists?
      query(@connection, @base_path)
    end

    def fetch_services
      query(@connection, @base_path + 'services').split(',')
    end

    def add_service(name)
      @services << name
    end

    def save_node
      services = @services.join(',')
      write(@connection, @base_path + 'services', services)
    end
  end
end
