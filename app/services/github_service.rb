class GithubService
  def initialize(token, username)
    @token = token
    @username = username
  end

  def get_repos
    get_json('repos')[0..4]
  end

  def get_followers
    get_json('followers')
  end

  def get_followings
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
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
