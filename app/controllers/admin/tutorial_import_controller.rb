class Admin::TutorialImportController < ApplicationController
  def create
    tutorial = Tutorial.create(tutorial_params)
    create_videos(tutorial)
    flash[:success] = "Successfully created tutorial.
    #{view_context.link_to('View it here.', tutorial_path(tutorial))}"
    redirect_to admin_dashboard_path
  end

  private

  def playlist_params
    params[:tutorial][:playlist_id]
  end

  def tutorial_params
    params.require(:tutorial).permit(:title,
                                     :description,
                                     :thumbnail,
                                     :playlist_id)
  end

  def new_video_params(info)
    { title: info[:snippet][:title],
      description: info[:snippet][:description],
      video_id: info[:contentDetails][:videoId],
      thumbnail: info[:snippet][:thumbnails][:high][:url] }
  end

  def create_videos(tutorial)
    youtube = YoutubeService.new
    video_info = youtube.playlist_info(playlist_params)
    video_info.each do |info|
      tutorial.videos.create(new_video_params(info))
    end
  end
end
