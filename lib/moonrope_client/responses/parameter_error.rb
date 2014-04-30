module MoonropeClient
  module Responses
    class ParameterError < Response
      
      def message
        data['message']
      end
      
    end
  end
end
