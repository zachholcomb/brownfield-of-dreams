class GithubService
  def initialize(token, username)
    @token = token
    @username = username
  end

  def repos
    get_json('repos')[0..4]
  end

  def followers
    get_json('followers')
  end

  def followings
    get_json('following')
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com/users/#{@username}/") do |req|
      req.params['token']
      req.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
