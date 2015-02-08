require 'rails_helper'

describe "Beer" do
  before :each do
    user = FactoryGirl.create :user
    visit signin_path      
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "is created when given a valid name on page" do
    visit new_beer_path
    fill_in('beer_name', with:'SomeBeer')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is redirected back to new beer form if name is empty" do
    visit new_beer_path
    click_button('Create Beer')
    expect(page).to have_button 'Create Beer'
    expect(page).to have_content 'Name can\'t be blank'
    expect(Beer.count).to eq(0)
  end
end

