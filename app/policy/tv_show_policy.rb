class TvShowPolicy
  attr_reader :user, :tv_show

  def initialize(user, tv_show)
    @user = user
    @tv_show = tv_show
  end

  def can_change?
    user.id = tv_show.user_id
  end
end