require 'spec_helper'

module TrafficSpy
  describe Request do
    let(:request){ Request.new(:data   => "Hello, World",
                               :source => "testapp")}

    before(:each) do
      Request.destroy_all
    end

    it "has data" do
      expect(request.data).to eq "Hello, World"
    end

    it "has a source" do
      expect(request.source).to eq "testapp"
    end

    describe ".exists?" do
      it "is false when the request is unique" do
        expect( Request.exists?(request) ).to_not be
      end

      it "is true when the request is a duplicate for that application" do
        request.save
        expect( Request.exists?(request) ).to be
      end

      it "is false when the request has duplicate data but a different application" do
        request.save
        request2 = Request.new(:source => "testapp2", :data => request.data)
        expect( Request.exists?(request2) ).to_not be
      end 
    end

    describe "#save" do
      it "stores the request" do
        expect{ request.save }.to change{ Request.count }.by(1)
      end
    end

    describe "#==" do
      it "checks equality of the data and source" do
        request1 = request
        request2 = request.dup
        expect(request1).to eq request2
      end
    end

    describe ".destroy_all" do
      it "removes all requests" do
        request.save
        Request.destroy_all
        expect( Request.count ).to eq 0
      end
    end
  end
end