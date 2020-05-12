class GithubService
  def initialize(token, username)
    @token = token
    @username = username
  end

  def repos
    get_json("user/repos?access_token=#{@token}")[0..4]
  end

  def followers
    get_json("user/followers?access_token=#{@token}")
  end

  def followings
    get_json("user/following?access_token=#{@token}")
  end

  def get_user(username)
    get_json("/users/#{username}")
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com') do |req|
      req.params['token']
      req.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
