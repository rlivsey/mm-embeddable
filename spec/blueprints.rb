require 'machinist/mongo_mapper'
require 'sham'
require 'faker'

Sham.name { Faker::Name.name }
Sham.login { Faker::Internet.user_name }
Sham.bio { Faker::Lorem.sentence(30) }
Sham.subject { Faker::Lorem.sentence(10) }
Sham.body { Faker::Lorem.paragraphs(4).join("\n\n") }

TestUser.blueprint do
  name
  login
  bio
end

TestMessage.blueprint do
  sender { TestUser.make }
  receivers { [TestUser.make, TestUser.make] }
  subject
  body
end