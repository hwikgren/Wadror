require 'spec_helper'

describe "BeermappingApi" do
  it "when HTTP GET return one entry, parses and return the location" do
    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location>
    <id>12411</id>
    <name>Gallows Bird</name>
    <status>Brewery</status>
    <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink>
    <proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink>
    <blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap>
    <street>Merituulentie 30</street>
    <city>Espoo</city>
    <state nil="true"/>
    <zip>02200</zip>
    <country>Finland</country>
    <phone>+358 9 412 3253</phone>
    <overall>91.66665</overall>
    <imagecount>0</imagecount>
  </location>
</bmp-locations>
    END_OF_STRING
    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    places = BeermappingApi.places_in("espoo")
    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Gallows Bird")
    expect(place.street).to eq("Merituulentie 30")
  end

  it "when HTTP GET returns no entries, and empty array is returned" do
    canned_answer = <<-END_OF_STRING
    <?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location>
    <id nil="true"/>
    <name nil="true"/>
    <status nil="true"/>
    <reviewlink nil="true"/>
    <proxylink nil="true"/>
    <blogmap nil="true"/>
    <street nil="true"/>
    <city nil="true"/>
    <state nil="true"/>
    <zip nil="true"/>
    <country nil="true"/>
    <phone nil="true"/>
    <overall nil="true"/>
    <imagecount nil="true"/>
  </location>
</bmp-locations>
    END_OF_STRING
    stub_request(:get, /.*kuusamo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    places = BeermappingApi.places_in("kuusamo")
    expect(places.size).to eq(0)
  end

  it "when HTTP GET returns several entries, and array with several places is returned" do
    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location type="array">
    <location>
      <id>13307</id>
      <name>O'Connell's Irish Bar</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap>
      <street>Rautatienkatu 24</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33100</zip>
      <country>Finland</country>
      <phone>35832227032</phone>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>18845</id>
      <name>Pyynikin panimo</name>
      <status>Brewery</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18845</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=18845&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=18845&amp;d=1&amp;type=norm</blogmap>
      <street>Tesoman valtatie 24</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33300</zip>
      <country>Finland</country>
      <phone nil="true"/>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>18857</id>
      <name>Panimoravintola Plevna</name>
      <status>Brewpub</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18857</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=18857&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=18857&amp;d=1&amp;type=norm</blogmap>
      <street>Itainenkatu 8</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33210</zip>
      <country>Finland</country>
      <phone nil="true"/>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
  </location>
</bmp-locations>
    END_OF_STRING
    stub_request(:get, /.*tampere/).to_return(body:canned_answer, headers: { 'Content-Type' => "text/xml" })
    places = BeermappingApi.places_in("tampere")
    expect(places.size).to eq(3)
    place = places.first
    expect(place.name).to eq("O'Connell's Irish Bar")
    place = places.last
    expect(place.status).to eq("Brewpub")
  end
end
