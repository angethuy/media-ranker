module ApplicationHelper

  def pretty_date(date)
    return "[unknown]" unless date
    return content_tag(:span, date.strftime("%b %d, %Y"), class: 'date', title: date.to_s)
  end

  def auth_button(user)
    if user
      return content_tag(:a, "Logout", class: 'btn btn-primary', href: '/logout', rel: "nofollow", data: { method: "post"})
    else 
      return content_tag(:a, "Login", class: 'btn btn-primary', href: '/login')
    end
  end

  def profile_button(user)
    return content_tag(:a, "Logged in as #{user.name}", class: 'btn btn-primary', href: user_path(user.id))
  end
end


