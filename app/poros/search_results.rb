class SearchResults
  def initialize(user)
    @user = user
    @github_service = GithubService.new(@user.token, @user.github_user)
  end

  def repos
    json = @github_service.get_repos
    @repos = json.map do |repo|
      Repo.new(repo[:name], repo[:html_url])
    end
  end

  def followers
    json = @github_service.get_followers
    @followers = json.map do |user|
      Follower.new(user[:login], user[:html_url])
    end
  end

  def followings
    json = @github_service.get_followings
    @followers = json.map do |user|
      Following.new(user[:login], user[:html_url])
    end
  end
end
