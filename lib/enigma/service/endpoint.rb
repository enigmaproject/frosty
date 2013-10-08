class Enigma
  class Service
    class Endpoint
      attr_accessor :status, :port, :role
      def initialize(ip, port, role)
        @ip = ip
        @port = port
        @role = role
      end
    end
  end
end
