module TrafficSpy
  class Source
    attr_reader :identifier, :root_url, :errors

    def initialize(params)
      @identifier = params[:identifier]
      @root_url = params[:root_url]
    end

    def valid?
      @errors = []
      if !identifier
        @errors << ValidationError.new(:category => :missing_parameter, 
                                       :message => "Missing 'identifier' parameter")
      end
      if !root_url
        @errors << ValidationError.new(:category => :missing_parameter, 
                                       :message => "Missing 'rootUrl' parameter")
      end
      if Source.registered?(identifier)
        @errors << ValidationError.new(:category => :repeated_identifier,
                                       :message  => "Sorry, indentifier '#{identifier}' has already been taken")
      end
      @errors.empty?
    end

    def save
      Source.all << self
      self
    end

    def self.all
      @sources ||= []
    end

    def self.count
      all.count
    end

    def self.destroy_all
      @sources = []
    end

    def self.registered?(identifier)
      all.any?{|source| source.identifier == identifier}
    end

    def self.create(params)
      new(params).save
    end
  end
end