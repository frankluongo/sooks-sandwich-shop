module ApplicationHelper
  def auth_or_unauth
    if user_signed_in?
      render "layouts/auth_or_unauth/authed"
    else
      render "layouts/auth_or_unauth/unauthed"
    end
  end

  def cart_in_nav

  end
end
