module TrafficSpy
  class DataController
    def self.create(params)
      if Source.registered?(params[:application])
        if params[:payload]
          Request.create
          status = 200
          body   = ""
        else
          status = 400
          body   = "missing payload"
        end
      else
        status = 403
        body   = "application not registered with identifier #{params[:application]}"
      end

      Response.new(:status => status, :body => body)
    end
  end
end