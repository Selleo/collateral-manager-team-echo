# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! email: 'admin@admin.com', password: 'Admin123', password_confirmation: 'Admin123'
Tag.create! name: 'ruby', category: 0
Tag.create! name: 'en', category: 2
Tag.create! name: 'crm', category: 1
Tag.create! name: 'rails', category: 0
Tag.create! name: 'recruitment', category: 1
collateral = Collateral.create! name: 'Ruby is awesome!', link: 'http://blog.selleo.com/ruby-roxxx', kind: 2
Tag.all.each do |tag|
  TagAssignment.assign(tag, collateral,1)
end

