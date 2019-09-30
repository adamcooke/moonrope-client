module MoonropeClient
  module Responses
    class ParameterError < Response

      def message
        data['message']
      end

      def exception_message
        self.message
      end

    end
  end
end
