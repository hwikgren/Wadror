require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, is shown at the page" do
    BeermappingApi.stub(:places_in).with("Kumpula").and_return(
      [ Place.new(:name => "Oljenkorsi", :id => 1) ]
    )
    visit places_path
    fill_in('city', with:'Kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, are shown at the page" do
    BeermappingApi.stub(:places_in).with("helsinki").and_return(
     [ Place.new(:name => "Oljenkorsi", :id => 1), Place.new(:name => "Kaisla", :id => 2) ]
    )
    visit places_path
    fill_in('city', with:'helsinki')
    click_button "Search"
    expect(page).to have_content "Kaisla"
    expect(page).to have_content "Oljenkorsi"
  end

  it "if no are returned by the API, none are shown on the page" do
    BeermappingApi.stub(:places_in).with("helsinki").and_return([])
    visit places_path
    fill_in('city', with:'helsinki')
    click_button "Search"
    expect(page).to have_content "No locations in helsinki"
  end
end
