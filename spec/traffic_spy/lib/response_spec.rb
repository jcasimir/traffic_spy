require 'spec_helper'

module TrafficSpy
  describe Response do
    let(:response){ Response.new(:status => 200, :body => "Everything is cool") }
    
    it "has the correct status" do
      expect( response.status ).to eq 200
    end
    
    it "has the correct body" do
      expect( response.body ).to eq "Everything is cool"
    end

    it "defaults to a blank body" do
      r = Response.new()
      expect( r.body ).to eq ""
    end

    it "defaults to status of 200" do
      r = Response.new()
      expect( r.status ).to eq 200
    end

    
  end
end