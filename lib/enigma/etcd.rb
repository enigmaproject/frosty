class Enigma
  module Etcd
    def query(connection, key)
      begin
        connection.get(key)
      rescue
        nil
      end
    end

    def write(connection, key, value)
      begin
        connection.set(key, value)
      rescue
        nil
      end
    end

    def hashify(responses)
      h = {}
      responses.each do |response|
        unless response.value.nil?
          h[response.key.split('/').pop] = response.value
        end
      end
      h
    end
  end
end
