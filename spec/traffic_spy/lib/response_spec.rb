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
      expect( Response.new.body ).to eq ""
    end

    it "defaults to status of 200" do
      expect( Response.new.status ).to eq 200
    end

    
  end
end