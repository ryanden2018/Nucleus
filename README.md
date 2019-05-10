# README

Nucleus is a social media app for the twenty-first century.

The app is based around friendships between users, and subscriptions to groups.
Two users can be friends with each other; or, one user can block another user.
Posts can be public or private. Private posts are only visible to the creator's
friends. Public posts are visible to anyone (even people without an account)
and may optionally be listed in one or more groups. Users can comment on any
post to which they have access. Users can also vote on posts or comments
with a "plus" or "minus." Posts, groups and comments may all be edited or destroyed
by their creators. Users can delete their account, along with all posts they
have created. There is also an elementary moderation system. Posts and comments
may be flagged by anyone with an account. Certain users, known as "admins," have
extra privileges; they may choose to "unflag" or "hide" any flagged post. Once a
post or comment is hidden, no one (not even admins) may view it, but a superuser 
with access to the database may still chose to unhide a post after it has been 
hidden by an admin.

You will need a working Ruby on Rails installation to run Nucleus.

Setting up Nucleus proceeds as follows:

1. Clone the repository

2. In the main working directory, run ```bundle install``` followed by ```rake db:migrate```.

3. If desired, run ```rake db:seed``` to seed the database (this will take some time).

4. Run ```rails s``` to start the Rails server, and open the indicated URL in a web
browser.

At this point you may login with an existing account (see the db/seeds.rb file),
create a new account, or continue as a guest. One possibility is to login with
the username ```JohnSnow``` and password ```abcdef``` .