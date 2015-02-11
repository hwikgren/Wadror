require 'rails_helper'

RSpec.describe Beer, :type => :model do

  describe "with name and style" do
    let(:beer){ Beer.create name:"Olut", style_id:1 }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "with no name" do
    let(:beer){Beer.create style_id:1 }
  
    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

  describe "with no style" do
    let(:beer){ Beer.create name:"Olut" }

    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
