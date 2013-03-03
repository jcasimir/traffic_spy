module TrafficSpy
  class DataController
    def self.create(params)
      request = Request.new(:source => params[:application],
                            :data   => params[:payload])
      if request.valid?
        request.save
        status = 200
        body   = "data stored for application '#{params[:application]}'"
      else
        status = status_for(request.errors.first.category)
        body = request.errors.collect{|e| e.message}.join(", ")
      end

      Response.new(:status => status, :body => body)
    end

  private
    def self.status_for(flag)
      case flag
        when :missing_parameter then 400
        when :unregistered_application then 403
        when :duplicated_data then 403
        else raise "No return status defined for flag #{flag.inspect}"
      end
    end
  end
end