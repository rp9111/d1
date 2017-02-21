class Admin::ThemesController < Admin::AdminController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  # GET /admin/themes
  # GET /admin/themes.json
  def index
    @themes = Theme.all
  end

  # GET /admin/themes/1
  # GET /admin/themes/1.json
  def show
  end

  # GET /admin/themes/new
  def new
    @theme = Theme.new
  end

  # GET /admin/themes/1/edit
  def edit
  end

  # POST /admin/themes
  # POST /admin/themes.json
  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to admin_themes_url, notice: 'Theme was successfully created.' }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/themes/1
  # PATCH/PUT /admin/themes/1.json
  def update
    if @theme.update(theme_params)
      respond_to do |format|
        format.html { redirect_to admin_themes_url, notice: 'Theme was successfully updated.' }
        format.json { render json: @theme.errors, status: 422 }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @theme.errors, status: 422 }
      end
    end
  end

  # DELETE /admin/themes/1
  # DELETE /admin/themes/1.json
  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to admin_themes_url, notice: 'Theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:name, :structure, :style, :behavior)
    end
end
