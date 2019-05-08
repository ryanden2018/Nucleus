# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

usr1 = User.create(username:"S8n",first_name:"Lucifer",last_name:"Devil",password:"abcdef",age:666,avatar_url:"/assets/Quarky.png")
User.create(username:"Susan",first_name:"Susan",last_name:"Barnes",age:28,password:"abcdef",avatar_url:"/assets/Quarky.png")
User.create(username:"JohnSnow",first_name:"John",last_name:"Snow",age:37,password:"abcdef",avatar_url:"/assets/Quarky.png")
User.create(username:"Max",first_name:"Max",last_name:"Stevens",age:19,password:"abcdef",avatar_url:"/assets/Quarky.png")

Group.create(name:"Physics",description:"All things physics",owner_id:usr1.id)
Group.create(name:"Rubles",description:"Rubles",owner_id:usr1.id)

Post.create(title:"Test post",content:"Test content",user_id:usr1.id,edited:false,private:false)
Post.create(title:"Another test post",content:"More test content",user_id:usr1.id,edited:false,private:false)
