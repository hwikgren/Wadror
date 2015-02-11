require 'rails_helper'

RSpec.describe User, :type => :model do

  it "has the username set correctly" do
    user = User.new username:"Pekka"
    
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with too short password" do
    let(:user){ User.create username:"Pekka", password:"Se1", password_confirmation:"Se1" }
    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end 
  end

  describe "with password of all letters" do
    let(:user){ User.create username:"Pekka", password:"Secret", password_confirmation:"Secret" }
    it "is not saved" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end


  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end 
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
    it "is the only rated one if only one rating" do
      beer = create_beer_with_rating(10, "lager", nil, user)
      expect(user.favorite_beer).to eq(beer)
    end
    it "is the one with the highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, "lager", nil, user)
      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end
    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end
    it "is the style of the only rated beer if only one rating" do
      beer = create_beer_with_rating(10, "lager", nil, user)
      expect(user.favorite_style).to eq("lager")
    end
    it "is the style with the highest average ratings" do
      create_beers_with_style_and_ratings("lager", 7, 9, user)
      create_beers_with_style_and_ratings("weizen", 25, 25, user)
      create_beers_with_style_and_ratings("nonalcoholic", 10, 12, user)
      expect(user.favorite_style).to eq("weizen")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end
    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end
    it "is the brewery of the only rated beer if only one rating" do
      beer = create_beer_with_rating(10, "lager", nil, user)
      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end
    it "is the brewery with the highest average ratings" do
      create_beers_with_ratings(7, 9, user)
      create_beers_with_brewery_and_ratings("weichenstephaner", 25, 25, user)
      create_beers_with_brewery_and_ratings("koff", 10, 12, user)
      expect(user.favorite_brewery).to eq("weichenstephaner")
    end
  end
end

def create_beer_with_rating(score, style, brewery, user)
  if brewery == nil
    brewery = FactoryGirl.create(:brewery)
  end
  styleObject = FactoryGirl.create(:style, name:style)
  beer = FactoryGirl.create(:beer, style_id:styleObject.id, brewery_id:brewery.id)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, "lager", nil, user)
  end
end

def create_beers_with_style_and_ratings(style, *ratings, user)
  ratings.each do |score|
    create_beer_with_rating(score, style, nil, user)
  end
end

def create_beers_with_brewery_and_ratings(brewery_name, *ratings, user)
  brewery = Brewery.create(name:brewery_name, year:1900)
  ratings.each do |score|
    create_beer_with_rating(score, "lager", brewery, user)
  end
end

