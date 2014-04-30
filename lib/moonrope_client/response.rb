module MoonropeClient
  class Response
    
    #
    # Initialize a new response object
    # 
    # @param request [MoonropeClient::Request]
    # @param data [Hash]
    #
    def initialize(request, data)
      @request = request
      @data = data
    end
    
    #
    # Is this a successful response?
    #
    # @return [Boolean]
    #
    def success?
      false
    end
    
    # 
    # @return [String] the status of the request returned by the server
    #
    def status
      @data['status']
    end
    
    #
    # @return [Hash] any flags returned by the server
    def flags
      @data['flags']
    end
    
    #
    # @return [Object] the data returned by the server
    #
    def data
      @data['data']
    end
    
    #
    # @return [Float] the time the request took at the server
    #
    def time
      @data['time']
    end
    
  end
end
