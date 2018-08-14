class BookmarksController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, :except => :index

  def show
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.url = params[:bookmark][:url]
    @topic = Topic.find(params[:topic_id])
    @bookmark.topic = @topic
    @bookmark.user = current_user
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to topic_path(@topic)
    else
      flash[:error] = "There was an error creating the bookmark. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was updated"
      redirect_to topic_path(@topic)
    else
      flash[:error] = "Error saving bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to topic_path(@topic)
    else
      flash[:error] = "There was an error deleting the bookmark."
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
