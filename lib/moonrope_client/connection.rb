module MoonropeClient
  class Connection

    #
    # Initialize a new connection object to an API
    #
    #   moonrope = MoonropeClient::Connection.new('myapp.com', :ssl => true, :path_prefix => 'api')
    #
    # @param host [String] the hostname to connect to
    # @param options [Hash] A hash of options for this connectin
    #
    def initialize(host, options = {})
      @host, @options = host, options
    end

    #
    # @return [String] the endpoint hostname
    #
    attr_reader :host

    #
    # @return [String] the path prefix
    #
    def path_prefix
      @options[:path_prefix] || 'api'
    end

    #
    # @return [Boolean] whether or not SSL is enabled for requests or not
    #
    def ssl
      @options[:ssl] || false
    end

    #
    # @return [Integer] the port to conncet to
    #
    def port
      @options[:port] || (ssl ? 443 : 80)
    end

    #
    # @return [Hash] return headers to be set on all requests to the API
    #
    def headers
      @options[:headers] || {}
    end

    #
    # @return [Integer] the version of the API to use
    #
    def version
      @options[:version] || 1
    end

    #
    # @return [String] the User-Agent to send with the request
    #
    def user_agent
      @options[:user_agent] || "Moonrope Ruby Library/#{MoonropeClient::VERSION}"
    end

    #
    # Make a request and return an appropriate request object.
    #
    # @param controller [Symbol] the controller
    # @param action [Symbol] the action
    # @param params [Hash] parameters
    #
    def request(controller, action, params = {})
      MoonropeClient::Request.new(self, controller, action, params).make
    end

    def request!(controller, action, params = {})
      MoonropeClient::Request.new(self, controller, action, params).make!
    end

    def controller(name)
      MoonropeClient::Controller.new(self, name)
    end

    def method_missing(name, value = nil)
      value.nil? ? self.controller(name) : super
    end

    #
    # Make a request to the remote API server and return the raw output from
    # the request.
    #
    # @param path [String] the full path to request
    # @param params [Hash] a hash of parameters to send with the request
    #
    def raw_request(path, params = {})
      request = Net::HTTP::Post.new(path)
      request.set_form_data(params)
      request.add_field 'User-Agent', self.user_agent
      headers.each { |k,v| request.add_field k, v }
      connection = Net::HTTP.new(self.host, self.port)
      if ssl
        connection.use_ssl = true
        connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
      result = connection.request(request)
      case result.code.to_i
      when 200 then result.body
      when 400 then raise Error, "Bad request (400)"
      when 403 then raise Error, "Access denied (403)"
      when 404 then raise Error, "Page not found (404)"
      when 500 then raise Error, "Internal server error (500)"
      else          raise Error, "Unexpected status code #{result.code.to_i}"
      end
    end

  end
end
