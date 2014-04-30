module MoonropeClient
  module Responses
    class AccessDenied < Response
      
      def message
        data['message']
      end
      
    end
  end
end
