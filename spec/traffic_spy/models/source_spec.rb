require 'spec_helper'

module TrafficSpy
  describe Source do
    let(:source){ Source.new(:identifier => 'jumpstartlab', :root_url => 'http://jumpstartlab.com') }

    before(:each) do
      Source.destroy_all
    end

    it "has an identifier" do
      expect(source.identifier).to eq 'jumpstartlab'
    end

    it "has a root_url" do
      expect(source.root_url).to eq 'http://jumpstartlab.com'
    end

    describe "#valid" do
      context "when it has both an identifier and a root_url" do
        it "is" do
          expect( source ).to be_valid
        end

        context "but the identifier is a repeat" do
          it "is not" do
            source.save
            source2 = Source.new(:root_url => 'http://jumpstartlab.com', :identifier => 'jumpstartlab')
            expect( source2 ).to_not be_valid
          end
        end
      end

      context "when it is missing an identifier" do
        let(:source){ Source.new(:root_url => 'http://jumpstartlab.com') }

        it "is not" do
          expect(source).to_not be_valid
        end
      end

      context "when it is missing a root_url" do
        let(:source){ Source.new(:identifier => 'jumpstartlab') }

        it "is not" do
          expect(source).to_not be_valid
        end
      end
    end

    context "#save" do
      it "saves the source" do
        original_count = Source.count
        source.save
        expect( Source.count ).to be > original_count
      end
    end

    context "#count" do
      it "counts the Sources" do
        expect( Source.count ).to eq 0
        source.save
        expect( Source.count ).to eq 1
      end
    end

    context ".destroy_all" do
      it "removes all known sources" do
        source.save
        Source.destroy_all
        expect( Source.count ).to eq 0
      end
    end





    # describe "#save" do
    #   it "stores the Source" do
    #     expect { source.save }.to change{ Source.count }.by(1)
    #   end
    # end

    # describe ".destroy_all" do
    #   it "removes all stored Sources" do
    #     Source.destroy_all
    #     source.save
    #     expect( Source.count ).to eq 1
    #     Source.destroy_all
    #     expect( Source.count ).to eq 0
    #   end
    # end

    # describe ".registered?" do
    #   before(:each) do
    #     Source.destroy_all
    #   end

    #   it "is false when the app has not been registered" do
    #     expect(Source.registered?('asdf')).to_not be
    #   end

    #   it "is true when the app has been registered" do
    #     source.save
    #     expect(Source.registered?(source.identifier)).to be
    #   end
    # end

    # describe ".create" do
    #   let(:params){ { :identifier => 'jumpstartlab', :root_url => 'http://jumpstartlab.com'} }

    #   it "initializes and saves a source" do
    #     expect{ Source.create(params) }.to change{ Source.count }.by(1)
    #   end

    #   it "returns the created instance" do
    #     expect(Source.create(params)).to be_kind_of Source
    #   end
    # end
  end
end