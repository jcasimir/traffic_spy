module TrafficSpy
  class Request
    attr_reader :source, :data, :errors

    def initialize(inputs)
      @source = inputs[:source]
      @data   = inputs[:data]
    end

    def self.create
      all << Request.new
    end

    def self.all
      @requests ||= []
    end

    def self.count
      all.count
    end

    def valid?
      @errors = []
      if !source || !Source.registered?(source)
        @errors << ValidationError.new(:category => :unregistered_application,
                                       :message => "application '#{source}' is not registered")
      end
      if !data
        @errors << ValidationError.new(:category => :missing_parameter,
                                       :message => "payload missing")
      end
      if Request.exists?(self)
        @errors << ValidationError.new(:category => :duplicated_data,
                                       :message  => "Payload is a duplicate")
      end
      @errors.empty?
    end

    def save
      Request.all << self
    end

    def self.exists?(request)
      all.any?{|existing| existing == request}
    end

    def ==(other)
      (self.data == other.data) && (self.source == other.source)
    end

    def self.destroy_all
      @requests = []
    end
  end
end