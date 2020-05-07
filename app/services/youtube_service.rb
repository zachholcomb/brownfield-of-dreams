class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'contentDetails', playlistId: id, pageToken: '' }

    get_playlist_video_ids('youtube/v3/playlistItems', params)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_playlist_video_ids(url, params)
    video_ids = []
    response = conn.get(url, params)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:items].each do |item|
      video_ids << item[:contentDetails][:videoId]
    end
    until parsed_response[:nextPageToken].nil?
      params[:pageToken] = parsed_response[:nextPageToken]
      response = conn.get(url, params)
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      parsed_response[:items].each do |item|
        video_ids << item[:contentDetails][:videoId]
      end
      params[:pageToken] = parsed_response[:nextPageToken]
    end
    require 'pry'; binding.pry
    video_ids
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
