class GithubService
  def initialize(token, username)
    @token = token
    @username = username
  end

  def repos
    get_json('repos', @token)[0..4]
  end

  def followers
    get_json('followers', @token)
  end

  def followings
    get_json('following', @token)
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com/user/") do |req|
      req.adapter Faraday.default_adapter
    end
  end

  def get_json(url, token)
    response = conn.get(url, access_token: token)
    JSON.parse(response.body, symbolize_names: true)
  end
end
