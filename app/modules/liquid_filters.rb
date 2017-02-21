module LiquidFilters
  def markdownify(content)
    options = {
      filter_html:          false,
      hard_wrap:            false,
      space_after_headers:  false,
      lax_spacing:          true,
      fenced_code_blocks:   true
    }

    res = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(options)).render(content)
    res
  end
end

Liquid::Template.register_filter(LiquidFilters)