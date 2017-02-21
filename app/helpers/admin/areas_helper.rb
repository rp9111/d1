module Admin
  module AreasHelper
    def layout_name(area)
      name = Area::LAYOUTS.detect { |_h, k| k == area.mode }
      name ? name[0] : ''
    end
    def theme_name(area)
      area.theme.present? ? area.theme.name : 'No theme selected'
    end
  end
end
