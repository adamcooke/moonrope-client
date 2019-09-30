module MoonropeClient
  module Responses
    class ValidationError < Response

      def errors
        data['errors']
      end

      def exception_message
        self.errors.join(', ')
      end

    end
  end
end
