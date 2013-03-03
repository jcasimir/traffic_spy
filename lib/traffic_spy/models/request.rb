module TrafficSpy
  class Request
    def self.create
      all << Request.new
    end

    def self.all
      @request ||= []
    end

    def self.count
      all.count
    end
  end
end