class LikesController < ApplicationController
  before_action :set_topic :set_bookmark
   def create
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Liked bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:error] = "Error liking bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    end
  end

   def destroy
    like = Like.where(bookmark_id: @bookmark.id, user_id: current_user.id).first

     if like.destroy
      flash[:notice] = "Unliked bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:error] = "Error unliking bookmark"
      redirect_to [@bookmark.topic, @bookmark]
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
   def set_bookmark
    @bookmark = @topic.bookmarks.find(params[:bookmark_id])
  end

end
