module TrafficSpy
  class Server < Sinatra::Base
    set :views, 'lib/traffic_spy/views'
    set :static, true

    post '/sources' do
      response_for(SourcesController.create(params))
    end

    post '/sources/:application/data' do
      response_for(DataController.create(params))
    end

    get '/sources/:application' do
      @ranked_urls = StatsController.ranked_urls(params[:application])
      erb :stats
    end

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    def response_for(response)
      status response.status
      body   response.body
    end
  end

end