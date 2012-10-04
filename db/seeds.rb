# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20000.times do
  Item.create(
    bytes: Random.number(9999),
    mime_type: ['test/gif', 'test/jpeg', 'test/pdf', 'test/mp4'].sample,
    #description: Random.paragraphs[0...150],
    path: "/test/#{Random.firstname}_#{Random.lastname}",
    category_id: Category.all.sample.id,
    user_id: User.first.id)
end