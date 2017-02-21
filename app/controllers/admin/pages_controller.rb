class Admin::PagesController < Admin::AdminController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.includes([:user, :area])
    if params[:order_by].present?
      @current_sort_column = params[:order_by]
      @sort_dir = params[:dir].blank? ? 'ASC' : params[:dir]
      @pages = @pages.order('%s %s' % [@current_sort_column, @sort_dir])
    end
    @pages = @pages.page(params[:page]).per(20)
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new(area_id: params[:area_id])
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.user = current_user
    @page.position = @page.area.pages.size + 1

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_admin_area_path(@page.area), notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to edit_admin_area_path(@page.area), notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_area_path(@page.area), notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reorder
    Page.reorder params[:ids]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:title, :content, :cover, :permalink, :area_id, :commentable, :properties, :position, :user_id, :publish, :published_at, :pull_at, :classes)
  end
end
