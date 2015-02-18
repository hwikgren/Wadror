# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

s1 = Style.create name:"Lager", description:"Lager (German: storage) is a type of beer that is fermented and conditioned at low temperatures."
s2 = Style.create name:"Pale Ale", description:"Of British origin, this style is now popular worldwide and the use of local ingredients, or imported, produces variances in character from region to region. Generally, expect a good balance of malt and hops. Fruity esters and diacetyl can vary from none to moderate, and bitterness can range from lightly floral to pungent. American versions tend to be cleaner and hoppier, while British tend to be more malty, buttery, aromatic and balanced."
s3 = Style.create name:"Porter", description:"Some brewers made a stronger, more robust version, to be shipped across the North Sea, dubbed a Baltic Porter."
s4 = Style.create name:"Weizen", description:"A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The 'Hefe' prefix means 'with yeast', hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer. Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention."
s5 = Style.create name:"IPA", description:"The American IPA is a different soul from the reincarnated IPA style. More flavorful than the withering English IPA, color can range from very pale golden to reddish amber. Hops are typically American with a big herbal and / or citric character, bitterness is high as well. Moderate to medium bodied with a balancing malt backbone."
s6 = Style.create name:"Lowalcohol", description:"Low Alcohol Beer is also commonly known as Non Alcohol (NA) beer, which is a fallacy as all of these beers still contain small amounts of alcohol. Low Alcohol Beers are generally subjected to one of two things: a controlled brewing process that results in a low alcohol content, or the alcohol is removed using a reverse-osmosis method which passes alcohol through a permeable membrane. Very light on aroma, body, and flavor."


b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

beer1 = b1.beers.create name:"Iso 3", style_id:s1.id
beer2 = b1.beers.create name:"Karhu", style_id:s1.id
beer3 = b1.beers.create name:"Tuplahumala", style_id:s1.id
beer4 = b2.beers.create name:"Huvila Pale Ale", style_id:s2.id
beer5 = b2.beers.create name:"X Porter", style_id:s3.id
beer6 = b3.beers.create name:"Hefezeizen", style_id:s4.id
beer7 = b3.beers.create name:"Helles", style_id:s1.id

u1 = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1", admin:false, iced:false
u2 = User.create username:"Tommi", password:"Secret1", password_confirmation:"Secret1", admin:true, iced:false
u3 = User.create username:"Juppi", password:"Secret1", password_confirmation:"Secret1", admin:false, iced:true

Rating.create score:10, beer:beer1, user:u1
Rating.create score:15, beer:beer2, user:u1
Rating.create score:20, beer:beer4, user:u1
Rating.create score:17, beer:beer2, user:u2
Rating.create score:30, beer:beer6, user:u2
Rating.create score:21, beer:beer5, user:u3

club1 = BeerClub.create name:"Vallilan hiivaveikot", founded:2005, city:"Helsinki"
club2 = BeerClub.create name:"Rekolan olutseura", founded:2013, city:"Vantaa"

Membership.create user:u1, beer_club:club1
Membership.create user:u2, beer_club:club1
Membership.create user:u2, beer_club:club2


