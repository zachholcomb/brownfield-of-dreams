class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'snippet,contentDetails',
               playlistId: id,
               pageToken: '',
               maxResults: 50 }

    get_playlist_video('youtube/v3/playlistItems', params)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_playlist_video(url, params)
    video_info = []
    loop do
      parsed_response = get_json(url, params)
      params[:pageToken] = parsed_response[:nextPageToken]
      parsed_response[:items].each do |item|
        video_info << item
      end
      break if parsed_response[:nextPageToken].nil?
    end
    video_info.flatten
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
