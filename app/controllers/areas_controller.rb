class AreasController < ApplicationController
  before_action :global
  before_action :set_area, only: [:show]

  def show
    # @area.impress(request, current_user)
    @page_title = @page ? @page.title : @area.name
    @page.impress(request, current_user) if @page
    render 'show', layout: 'themer'
  end

  private

  def set_area
    @area = Area.where(id: params[:id]).take
    @area ||= Area.where('name ilike ?', params[:permalink]).take
    @area ||= Area.first
    if @area
      @page = @area.pages.find_by(position: [params[:page].to_i]) if params[:page].present?
    end
    @skus = Sku.all.to_a
  end
  
end
