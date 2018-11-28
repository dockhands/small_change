# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.destroy_all
Deed.destroy_all

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    puts row.to_hash

    u = User.new
    u.username = row['username']
    u.first_name = row['first_name']
    u.last_name = row['last_name']
    u.wallet= row['wallet']
    u.city= row['city']
    u.email = row['email']
    u.password= row['password']
    u.password_confirmation= row['password_confirmation']
    u.save
    puts "#{u.first_name} saved"
  end

    puts "There are now #{User.count} rows in the Users table"

    users = User.all

    csv_text = File.read(Rails.root.join('lib', 'seeds', 'deeds.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
    puts row.to_hash

 d = Deed.new
    d.title = row['title']
    d.body = row['body']
    d.money_required= row['money_required']
    d.city= row['city']
    d.all_tags = row['all_tags']
    d.money_raised= row['money_raised']
    d.user = users.sample
    d.save
  end

  puts "Created #{Deed.count} Deeds"