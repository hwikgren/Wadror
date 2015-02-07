# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

beer1 = b1.beers.create name:"Iso 3", style:"Lager"
beer2 = b1.beers.create name:"Karhu", style:"Lager"
beer3 = b1.beers.create name:"Tuplahumala", style:"Lager"
beer4 = b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
beer5 = b2.beers.create name:"X Porter", style:"Porter"
beer6 = b3.beers.create name:"Hefezeizen", style:"Weizen"
beer7 = b3.beers.create name:"Helles", style:"Lager"

u1 = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
u2 = User.create username:"Tommi", password:"Secret1", password_confirmation:"Secret1"
u3 = User.create username:"Juppi", password:"Secret1", password_confirmation:"Secret1"

Rating.create score:10, beer:beer1, user:u1
Rating.create score:15, beer:beer2, user:u1
Rating.create score:20, beer:beer4, user:u1
Rating.create score:17, beer:beer2, user:u2
Rating.create score:30, beer:beer6, user:u2
Rating.create score:21, beer:beer5, user:u3

club1 = BeerClub.create name:"Vallilan hiivaveikot", city:"Helsinki"
club2 = BeerClub.create name:"Rekolan olutseura", city:"Vantaa"

Membership.create user:u1, beer_club:club1
Membership.create user:u2, beer_club:club1
Membership.create user:u2, beer_club:club2

