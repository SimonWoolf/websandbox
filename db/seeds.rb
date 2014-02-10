# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.create(name: 'a', email: 'a@a.com', password: 'password', password_confirmation: 'password')
a.profile = Profile.create(html:"<p>seed example</p>")

b = User.create(name: 'b', email: 'b@b.com', password: 'password', password_confirmation: 'password')
b.profile = Profile.create(html:"<p>seed example</p>")
