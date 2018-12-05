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


PASSWORD = "herewego"

super_user = User.create(
  username: "Dandan",
  city: "Vancouver",
  wallet: 30,
  first_name: "Daniel",
  last_name: "Hawkins",
  email: "danielroberthawkins@gmail.com",
  password: PASSWORD,
  admin: true
)


r = Random.new

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
   

    u = User.new
    u.username = row['username']
    u.first_name = row['first_name'].capitalize 
    u.last_name = row['last_name'].capitalize 
    u.wallet= row['wallet']
    u.city= row['city']
    u.email = row['email']
    u.password= row['password']
    u.password_confirmation= row['password_confirmation']
    u.save
   
  end
    puts User.first.id
    puts "There are now #{User.count} rows in the Users table"
    puts User.last.id

    users = User.all
    
    

    csv_text = File.read(Rails.root.join('lib', 'seeds', 'deeds.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    
    csv.each do |row|
      puts row.to_hash

      d = Deed.new
      d.title = row['title'].capitalize 
      d.body = row['body'].capitalize 
      d.money_required = row['money_required']
      d.money_raised = row['money_raised']
      d.city = row['city'].capitalize 
      d.all_tags = row['all_tags']
      d.user = users.sample
      d.save

      timesFunded = d.money_raised 

     # puts User.where.not(id: d.user).sample


      (1..timesFunded).each do |i|
        
      f = Fund.new(
          :user_id => User.find(User.first.id+i).id, #.where.not(id: d.user)
          :deed_id => d.id
        )
        f.save
       puts f 
      end 

    end


  puts "Created #{Deed.count} Deeds"
