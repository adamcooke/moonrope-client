module MoonropeClient
  module Responses
    class Success < Response
      
      def success?
        true
      end
      
      #
      # @return [Boolean] whether this is a creation or not
      #
      def creation?
        flags['creation']
      end
      
      #
      # @return [Boolean] whether this is a modification or not
      #
      def modification?
        flags['modification']
      end
      
      #
      # @return [Boolean] whether this is a deletion or not
      #
      def deletion?
        flags['deletion']
      end
      
    end
  end
end
