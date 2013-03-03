require 'spec_helper'

module TrafficSpy
  describe ValidationError do
    let(:validation_error){ ValidationError.new(:category => :invalid_parameter, :message => "Parameter is invalid") }

    it "has a category" do
      expect(validation_error.category).to eq :invalid_parameter
    end

    it "has a message" do
      expect(validation_error.message).to eq "Parameter is invalid"
    end

  end
end