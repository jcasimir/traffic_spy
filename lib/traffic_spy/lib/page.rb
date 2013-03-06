module TrafficSpy
  class Page
    attr_accessor :url, :visits

    def initialize(inputs)
      @url    = inputs[:url]
      @visits = inputs[:visits]
    end
  end
end