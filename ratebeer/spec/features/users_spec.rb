require 'rails_helper'

describe "User" do
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do

    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'Foobar1')
      click_button('Log in')
      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'wrong')
      click_button('Log in')
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "who has rated beers" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryGirl.create :beer, style:"lager", brewery:brewery }
    let!(:rating1) {FactoryGirl.create(:rating, beer:beer1, user:user) }

    it "his favorite style and brewery are shown on his page" do
      visit user_path(user)
      expect(page).to have_content 'Favorite beer style is lager'
      expect(page).to have_content 'Favorite brewery is Koff'
    end

    it "even if he has rated many beers" do
      brewery2 = FactoryGirl.create :brewery 
      beer2 = FactoryGirl.create :beer, style:"Weizen", brewery:brewery2
      FactoryGirl.create(:rating, score:20, beer:beer2, user:user) 
      visit user_path(user)
      expect(page).to have_content 'Favorite beer style is Weizen'
      expect(page).to have_content 'Favorite brewery is anonymous'
    end
  end
    
end
