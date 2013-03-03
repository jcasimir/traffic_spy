require 'spec_helper'

module TrafficSpy
  describe SourcesController do
    before(:each) do
      Source.destroy_all
    end

    describe '.create' do
      it "accepts parameters" do
        expect{ SourcesController.create({}) }.to_not raise_error(ArgumentError)
      end

      context "given both identifier and rootURL" do
        it "returns 200 and a message" do
          result = SourcesController.create({:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'})
          expect(result.status).to eq 200
          expect(result.body.downcase).to include("created 'jumpstartlab' source for url 'http://jumpstartlab.com'")
        end

        context "given an existing identifier" do
          it "returns 403 and a message" do
            source1 = SourcesController.create({:identifier => 'jumpstartlab', :rootUrl => 'http://jumpstartlab.com'})
            source2 = SourcesController.create({:identifier => 'jumpstartlab', :rootUrl => 'http://tutorials.jumpstartlab.com'})
            expect( source2.status ).to eq 403
            expect( source2.body.downcase ).to include("sorry, indentifier 'jumpstartlab' has already been taken")
          end
        end
      end

      context "missing parameters" do
        it "returns 400 and a message when missing the identifier" do
          result = SourcesController.create({:rootUrl => 'http://google.com'})
          expect(result.status).to eq 400
          expect(result.body).to include("Missing 'identifier' parameter")
        end

        it "returns 400 and a message when missing the rootURL" do
          result = SourcesController.create({:identifier => 'jumpstartlab'})
          expect(result.status).to eq 400
          expect(result.body).to include("Missing 'rootUrl' parameter")
        end
      end
    end
  end
end