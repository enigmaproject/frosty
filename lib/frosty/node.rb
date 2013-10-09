require 'frosty/etcd'

class Frosty
  class Node
    include Frosty::Etcd

    def initialize(ip, environment, connection)
      @ip = ip
      @connection = connection
      @base_path = "/#{environment}/nodes/#{ip}/"
      refresh
    end

    def exists?
      if query(@connection, @base_path).nil?
        false
      else
        true
      end
    end

    def fetch_services
      ret = []
      if exists?
        services = query(@connection, @base_path + 'services')
        unless services.nil?
          ret = services.value.split(',')
        end
      end
      ret
    end

    def refresh
      @services = fetch_services
    end

    def add_service(name)
      @services.push name
    end

    def services
      @services
    end

    def save
      services = @services.join(',')
      write(@connection, @base_path + 'services', services)
    end
  end
end
