module MoonropeClient
  module Responses
    class PaginatedCollection < Success
      
      #
      # @return [Hash] all properties regarding pagination
      #
      def pagination_properties
        flags['paginated']
      end
      
      #
      # @return [Integer] the current page
      #
      def page
        pagination_properties['page']
      end
      
      #
      # @return [Integer] the total records per page
      #
      def per_page
        pagination_properties['per_page']
      end
      
      #
      # @return [Integer] the total number of pages
      #
      def total_pages
        pagination_properties['total_pages']
      end
      
      #
      # @return [Integer] the total number of records
      #
      def total_records
        pagination_properties['total_records']
      end
      
      #
      # @return [Array] all the items
      #
      def records
        data
      end
      
      #
      # @return [MoonropeClient::Responses::PaginatedCollection] the collection for the next page
      #
      def next_page
        request = @request.dup
        request.params[:page] = page + 1
        request.make
      end

      #
      # @return [MoonropeClient::Responses::PaginatedCollection] the collection for the previous page
      #
      def previous_page
        if page > 1
          request = @request.dup
          request.params[:page] = page - 1
          request.make
        else
          raise Error, "Cannot return the previous page as there is no page before page #{page}"
        end
      end
      
    end
  end
end
