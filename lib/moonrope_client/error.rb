module MoonropeClient
  class Error < StandardError
    def initialize(message, options = {})
      @message = message
      @options = options
    end

    def to_s
      @message
    end

    def options
      @options
    end
  end
end
