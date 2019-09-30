module MoonropeClient
  module Responses
    class AccessDenied < Response

      def message
        data['message']
      end

      def exception_message
        self.message
      end

    end
  end
end
