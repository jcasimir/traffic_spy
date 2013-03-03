require 'spec_helper'

describe "/sources" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "application registration at /sources" do
    context "given valid and unique parameters" do
      it "registers the application" do        
        request "/sources", :method => :post, :params => {:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'}
        last_response.should be_ok
        last_response.body.should == 'Registered "jumpstartlab" with root URL "http://jumpstartlab.com"'
      end
    end
  end
end