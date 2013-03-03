require 'spec_helper'

module TrafficSpy
  describe DataController do
    describe ".create" do
      context "when the application is not registered" do
        let(:params){ {:payload => Payload.sample, :application => 'asdf'} }

        it "returns 403 and a message" do
          result = DataController.create(params)
          expect(result.status).to eq 403
          expect(result.body.downcase).to include("application not registered")
        end
      end

      context "when the application is registered" do
        let!(:application) do
          Source.create(:identifier => 'jumpstartlab', :root_url => "http://jumpstartlab.com").identifier
        end

        context "with valid parameters" do
          let(:params){ { :payload => Payload.sample, :application => application } }

          it "creates a request record" do
            expect{ DataController.create(params) }.to change{ Request.count }.by(1)
          end

        end

        context "with a missing payload" do
          let(:params){ { :payload => nil, :application => application } }

          it "returns 400 and a message" do
            result = DataController.create(params)
            expect(result.status).to eq 400
            expect(result.body.downcase).to include("missing payload")
          end
        end
      end
    end
  end
end