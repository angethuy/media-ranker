module ApplicationHelper

  def auth_button(user)
    if user
      return content_tag(:a, "Logout", class: 'btn btn-primary', href: '/logout', data: { method: "post"})
    else 
      return content_tag(:a, "Login", class: 'btn btn-primary', href: '/login')
    end
  end

end


