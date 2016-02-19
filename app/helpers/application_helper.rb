module ApplicationHelper
  def page_title
    controller_name.humanize
  end

  def flash_class(level)
    case level
      when 'notice' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-danger'
      when 'alert' then 'alert alert-warning'
    end
  end

  def login_fb_path
    '/auth/facebook'
  end
end
