module TrafficSpy
  class SourcesController < Sinatra::Application
    def self.create(params)
      source = Source.new(:identifier => params[:identifier],
                          :root_url   => params[:rootUrl])
      if source.valid?
        source.save
        status = 200
        body = "OK - created '#{params[:identifier]}' source for URL '#{params[:rootUrl]}'"
      else
        status = status_for(source.errors.first.category)
        body = source.errors.collect{|e| e.message}.join(", ")
      end

      Response.new(:status => status, :body => body)
    end

  private
    def self.status_for(flag)
      case flag
        when :missing_parameter then 400
        when :repeated_identifier then 403
        else raise "No return status defined for flag #{flag.inspect}"
      end
    end
  end
end