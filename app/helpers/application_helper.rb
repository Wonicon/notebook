module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source, input: 'GFM', coderay_line_numbers: nil).to_html.html_safe
  end

  def active?(name)
    if name == session[:current_controller]
      'active'
    else
      ''
    end
  end
end
