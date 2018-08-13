class IncomingController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
      puts "INCOMING PARAMS HERE: #{params}"

       @user = User.find_by(email: params[:sender])

       @topic = Topic.find_by(title: params[:subject])

       @url = params["body-plain"]

       if @user == nil
         @user = User.new
         @user.email = params[:sender]
         @user.password = 'iamauser'
         @user.save!
       end

       # Check if the topic is nil, if so, create and save a new topic
       if @topic == nil
         @topic = Topic.new
         @topic.user_id = @user.id
         @topic.title = params[:subject]
         @topic.save!
       end

       # Now that you're sure you have a valid user and topic, build and save a new bookmark
       @bookmark = Bookmark.new
       @bookmark.topic_id = @topic.id
       @bookmark.url = @url.strip
       @bookmark.save!

      head 200
    end
end
