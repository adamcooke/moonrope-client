module MoonropeClient
  module Responses
    class ValidationError < Response
      
      def errors
        data['errors']
      end
      
    end
  end
end
