module TrafficSpy
  class Response
    attr_accessor :status, :body

    DEFAULT_STATUS_CODE = 200
    DEFAULT_BODY = ""

    def initialize(inputs = {})
      @status = inputs[:status] || DEFAULT_STATUS_CODE
      @body   = inputs[:body]   || DEFAULT_BODY
    end
  end
end