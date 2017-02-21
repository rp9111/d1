module ApplicationHelper

  def yes_no(val)
    val ? 'Yes' : 'No'
  end

  def liquidize(content, args)
    content = Liquid::Template.parse(content).render(args, filters: [LiquidFilters]).html_safe
    normalize_asset_paths content
  end

  def permitted?(area, user)
    user && user.has_access_to?(area)
  end

  def normalize_asset_paths(content)
    content = content.html_safe
    content.gsub /assets_url\(.*\)/ do |key|
      key = CGI.unescapeHTML key
      key =~ /assets_url\(['"](.*)['"]\)/
      "#{asset_path($1)}"
    end
  end
  
end
