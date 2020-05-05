module SessionsHelper
  def current_user
    # @current_userにログインユーザが代入されていたらそのまま、代入されていなければsessionからログインユーザを取得
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # ユーザがログインしていればtrue,していなければfalseを返す
    !!current_user
  end
end
