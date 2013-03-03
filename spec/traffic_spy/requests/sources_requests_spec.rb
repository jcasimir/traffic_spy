require 'spec_helper'

describe "/sources" do
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  before(:each) do
    TrafficSpy::Source.destroy_all
  end

  describe "application registration at /sources" do
    context "given valid and unique parameters" do
      it "registers the application" do        
        post "/sources", {:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'}
        expect(last_response).to be_ok
        expect(last_response.body.downcase).to include("created 'jumpstartlab' source for url 'http://jumpstartlab.com'")
      end
    end

    context "given parameters for an already existing application" do
      it "returns an error" do
        2.times { post "/sources", {:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'} }
        expect(last_response.status).to eq 403
      end
    end
  end

  describe "data submission at /sources/IDENTIFIER/data" do
    context "when the application is known" do
      before(:each) do
        post "/sources", {:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'}
      end

      it "accepts data" do
        post "/sources/jumpstartlab/data", {:payload => Payload.sample}
        expect(last_response.status).to eq 200
      end
    end

    context "when the application is not yet registered" do
      it "rejects data" do
        post "/sources/jumpstartlab/data", {:payload => Payload.sample}
        expect(last_response.status).to eq 403
      end
    end
  end
end