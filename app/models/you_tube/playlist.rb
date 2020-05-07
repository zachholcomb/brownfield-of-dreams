module YouTube
  class Playlist
    def self.by_id(id)
      new(YoutubeService.new.playlist_info(id))
    end
  end
end