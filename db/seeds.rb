# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Group.destroy_all
Subscription.destroy_all
Post.destroy_all
Block.destroy_all
Comment.destroy_all
Commentpluss.destroy_all
Friendship.destroy_all
GroupPost.destroy_all
Pluss.destroy_all
Request.destroy_all

lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n" * 3
lorem_ipsum_short = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

usr1 = User.create(username:"S8n",first_name:"Lucifer",last_name:"Devil",password:"abcdef",age:666,avatar_url:"https://pbs.twimg.com/profile_images/738139405446062081/x0FQk9Yl_400x400.jpg",:is_admin => false)
usr2 = User.create(username:"Susan",first_name:"Susan",last_name:"Barnes",age:28,password:"abcdef",avatar_url:"/assets/Quarky.png",is_admin:false)
usr3 = User.create(username:"JohnSnow",first_name:"John",last_name:"Snow",age:37,password:"abcdef",avatar_url:"/assets/Quarky.png",is_admin:false)
usr7 = User.create(username:"Max",first_name:"Max",last_name:"Stevens",age:19,password:"abcdef",avatar_url:"/assets/Quarky.png",is_admin:false)
usr8 = User.create(username:"Admin",first_name:"Ad",last_name:"Min",age:90,password:"abcdef",avatar_url:"/assets/Quarky.png",is_admin:true)
usr9 = User.create(username:"Yoda force",first_name:"Yoda",last_name:"Seagull",age:9000,password:"abcdef",avatar_url:"https://starwarsblog.starwars.com/wp-content/uploads/2015/11/yoda-the-empire-strikes-back-1536x864-349144518002.jpg",is_admin:true)
usr4 = User.create(username:"Nikki-summoner-of-deer",first_name:"Nikki",last_name:"Me",age:24,password:"abcdef",avatar_url:"https://media0.giphy.com/media/NipFetnQOuKhW/giphy.gif?cid=790b76115cd488aa6c2f71412efb70c0&rid=giphy.gif",is_admin:true)
usr5 = User.create(username:"Grevious",first_name:"General",last_name:"Sith",age:19,password:"abcdef",avatar_url:"https://vignette.wikia.nocookie.net/disney/images/6/65/Profile_-_General_Grievous.png/revision/latest?cb=20190313134830",is_admin:false)
usr6 = User.create(username:"No the droid",first_name:"Obi",last_name:"Kenobi",age:19,password:"abcdef",avatar_url:"https://vignette.wikia.nocookie.net/swfans/images/d/d1/ObiWanKenobi.jpg/revision/latest?cb=20130604153336",is_admin:false)

usrids = [usr1.id,usr2.id,usr3.id,usr4.id,usr5.id,usr6.id,usr7.id,usr8.id,usr9.id]


grp1 = Group.create(name:"Physics",description:"All things physics",owner_id:usr1.id)
grp2 = Group.create(name:"Rubles",description:"Rubles",owner_id:usr1.id)
grp3 = Group.create(name:"Kevin Bacon Society",description:"How fast can you find him?",owner_id:usr4.id)
Subscription.create(user_id:usr1.id,group_id:grp1.id)
Subscription.create(user_id:usr1.id,group_id:grp2.id)
Subscription.create(user_id:usr3.id,group_id:grp1.id)

grpids = [grp1.id,grp2.id,grp3.id]

pst1 = Post.create(title:"Trees",content:lorem_ipsum,user_id:usr1.id,edited:false,is_private:false,is_flagged:false,is_hidden:false)
Post.create(title:"Boats",content:lorem_ipsum,user_id:usr1.id,edited:false,is_private:false,is_flagged:false,is_hidden:false)
Post.create(title:"Kayaks",content:lorem_ipsum,user_id:usr3.id,edited:false,is_private:true,is_flagged:false,is_hidden:false)
pst2 = Post.create(title:"Hello", content:"Hello There", user_id:usr6.id,edited:false,is_private:false,is_flagged:false,is_hidden:false, image_url:"https://media.giphy.com/media/Nx0rz3jtxtEre/giphy.gif")


Block.create(blocker_id:usr2.id,blockee_id:usr1.id)

Friendship.create(user_1_id:usr1.id,user_2_id:usr3.id)
Friendship.create(user_1_id:usr3.id,user_2_id:usr1.id)

Friendship.create(user_1_id:usr2.id,user_2_id:usr3.id)
Friendship.create(user_1_id:usr3.id,user_2_id:usr2.id)

Comment.create(post_id:pst1.id,user_id:usr3.id,content:lorem_ipsum_short,edited:false,is_flagged:false,is_hidden:false)
Comment.create(post_id:pst2.id,user_id:usr5.id,content:"GENERAL KENOBI!!!",edited:false,is_flagged:false,is_hidden:false)

GroupPost.create(group_id:grp1.id,post_id:pst1.id)


10000.times do
  paragraphs = []

  5.times do
    paragraphs << Faker::Lorem.paragraph(sentence_count=10)
  end

  content = paragraphs.join("\n\n")

  p = Post.create(user_id:usrids.sample,
  content:content,
  title: Faker::ChuckNorris.fact,
  edited:false,
  is_private:false,
  is_flagged:false,
  is_hidden:false)


  GroupPost.create(group_id:grpids.sample, post_id:p.id)

  Comment.create(
    post_id:p.id,
    user_id:usrids.sample,
    content:Faker::Lorem.paragraph(sentence_count=10),
    edited:false,
    is_flagged:false,
    is_hidden:false
  )

  Comment.create(
    post_id:p.id,
    user_id:usrids.sample,
    content:Faker::Lorem.paragraph(sentence_count=10),
    edited:false,
    is_flagged:false,
    is_hidden:false
  )

  Comment.create(
    post_id:p.id,
    user_id:usrids.sample,
    content:Faker::Lorem.paragraph(sentence_count=10),
    edited:false,
    is_flagged:false,
    is_hidden:false
  )
end
