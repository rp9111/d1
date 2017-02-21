class Admin::AreasController < Admin::AdminController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.order(:position)
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    @pages = @area.pages
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)
    @area.skus = params[:area][:skus]
    respond_to do |format|
      if @area.save
        format.html { redirect_to admin_areas_path, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      @area.skus = params[:area][:skus]
      if @area.update area_params
        format.html { redirect_to admin_areas_path, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to admin_areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reorder
    Area.reorder params[:ids]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @area = Area.find(params[:id])
    # @area.theme = Theme.new if @area.theme.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def area_params
    params.require(:area).permit(:name, :theme_id, :label, :position, :navigation, :footer, :comments, :ascending, :mode, :paid, :restricted, array: [:sku])
  end
end
