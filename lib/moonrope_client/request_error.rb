module MoonropeClient
  class RequestError < StandardError
    def initialize(result)
      @result = result
    end
    attr_reader :result
  end
end
