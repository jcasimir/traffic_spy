module TrafficSpy
  class ValidationError
    attr_reader :category, :message

    def initialize(input)
      @category = input[:category]
      @message  = input[:message]
    end
  end
end