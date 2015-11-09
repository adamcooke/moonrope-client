module MoonropeClient
  class Controller

    def initialize(connection, controller_name)
      @connection = connection
      @controller_name = controller_name
    end

    attr_reader :name

    def method_missing(name, params = {})
      request(name, params)
    end

    def request(action_name, params = {})
      @connection.request(@controller_name, action_name, params)
    end

  end
end
