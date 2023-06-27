module UsersHelper
  def check_logged_in
    unless user_signed_in?
      flash[:danger] = 'You need to log in'
      redirect_to new_user_session_path
    end
  end

  def check_is_admin
    unless user_signed_in? && current_user.admin?
      render 'shared/access_denied'
    end
  end
end
