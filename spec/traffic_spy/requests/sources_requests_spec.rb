require 'spec_helper'

describe "/sources" do
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  describe "application registration at /sources" do
    context "given valid and unique parameters" do
      it "registers the application" do        
        post "/sources", {:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'}
        expect(last_response).to be_ok
        expect(last_response.body.downcase).to include("created 'jumpstartlab' source for url 'http://jumpstartlab.com'")
      end
    end
  end
end