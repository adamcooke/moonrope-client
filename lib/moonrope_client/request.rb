require 'moonrope_client/request_error'

module MoonropeClient
  class Request

    #
    # Initialize a new request
    #
    # @param connection [MoonropeClient::Connection]
    # @param controller [Symbol]
    # @param action [Symbol]
    # @param params [Hash]
    #
    def initialize(connection, controller, action, params = {})
      @connection = connection
      @controller = controller.to_sym
      @action = action.to_sym
      @params = params
    end

    attr_reader :params

    def make
      raw_data_to_response_object(make_request)
    end

    def make!
      result = raw_data_to_response_object(make_request)
      if result.success?
        result
      else
        raise MoonropeClient::RequestError.new(result), "Request was not successful. Got #{result.class} (#{result.exception_message})."
      end
    end

    private

    def make_request
      params = {:params => @params.to_json}
      path   = "/#{@connection.path_prefix}/v#{@connection.version}/#{@controller}/#{@action}"
      JSON.parse(@connection.raw_request(path, params))
    end

    #
    # Convert rhe result of a request into an appropriate response object
    #
    def raw_data_to_response_object(data)
      case data['status']
      when 'success'
        if data['flags']['paginated'] && data['data'].is_a?(Array)
          MoonropeClient::Responses::PaginatedCollection.new(self, data)
        else
          MoonropeClient::Responses::Success.new(self, data)
        end
      when 'parameter-error'  then MoonropeClient::Responses::ParameterError.new(self, data)
      when 'access-denied'    then MoonropeClient::Responses::AccessDenied.new(self, data)
      when 'validation-error' then MoonropeClient::Responses::ValidationError.new(self, data)
      else
        MoonropeClient::Response.new(self, data)
      end
    end

  end
end
