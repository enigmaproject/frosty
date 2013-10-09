class Frosty
  class Service
    class Endpoint
      attr_accessor :status, :port, :role
      attr_reader :ip
      def initialize(ip)
        @ip = ip
      end
    end
  end
end
