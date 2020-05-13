class Following
  attr_reader :name, :link

  def initialize(name, link)
    @name = name
    @link = link
  end

  def user?
    User.find_by(github_user: @name)
  end
end
