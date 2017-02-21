module AdminHelper
  def nav_link(label, path, icon = nil)
    content_tag :li, class: current_page?(path) ? 'active' : '' do
      link_to path do
        concat "<i class='icon ion-#{icon}'></i>".html_safe unless icon.nil?
        concat label
        concat content_tag(:span, '(current)', class: 'sr-only') if current_page?(path)
      end
    end
  end
end
