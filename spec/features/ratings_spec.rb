require 'rails_helper'
#include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
 #   sign_in(username:"Pekka", password:"Foobar1")
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)
    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "is shown" do
    before :each do
      FactoryGirl.create(:rating, beer:beer1, user:user)
      FactoryGirl.create(:rating, beer:beer2, user:user)
    end
    it "on ratings page" do
      visit ratings_path
       expect(page).to have_content 'karhu 10 Pekka'
    end

    it "on a user's page only own ones" do
      user2 = FactoryGirl.create(:user, username:'Jukka')
      FactoryGirl.create(:rating, beer:beer1, user:user2)
      visit user_path(user2)
      expect(page).to have_content 'Has made 1 rating'
      expect(page).to have_content 'iso 3 10'
      expect(page).to have_no_content 'karhu 10'
    end

    it "to disappear when user deletes it" do
      visit user_path(user)
      expect{
        page.all(:link, "delete")[0].click
      }.to change{user.ratings.count}.from(2).to(1)
      expect(page).to_not have_content 'iso 3 10'
      expect(page).to have_content 'karhu 10'
    end
  end
end

