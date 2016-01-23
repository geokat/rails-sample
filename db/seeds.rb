# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# Our seed file contains headers; skip them.
opts = {:headers => true}

CSV.foreach('data.csv', opts) do |row|
  Group.create!(name: row[1],
                balance: row[2],
                private: row[3] == "Y" ? true : false)
end
