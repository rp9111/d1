class Admin::SkusController < Admin::AdminController
  before_action :set_sku, only: [:show, :edit, :update, :destroy]

  # GET /skus
  # GET /skus.json
  def index
    @skus = Sku.all
    if params[:order_by].present?
      @current_sort_column = params[:order_by]
      @sort_dir = params[:dir].blank? ? 'ASC' : params[:dir]
      @skus = @skus.order('%s %s' % [@current_sort_column, @sort_dir])
    end
    @skus = @skus.page(params[:page]).per(20)
  end

  # GET /skus/1
  # GET /skus/1.json
  def show
  end

  # GET /skus/new
  def new
    @sku = Sku.new
  end

  # GET /skus/1/edit
  def edit
  end

  # POST /skus
  # POST /skus.json
  def create
    @sku = Sku.new(sku_params)

    respond_to do |format|
      if @sku.save
        format.html { redirect_to admin_skus_path, notice: 'Sku was successfully created.' }
        format.json { render :show, status: :created, location: @sku }
      else
        format.html { render :new }
        format.json { render json: @sku.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skus/1
  # PATCH/PUT /skus/1.json
  def update
    respond_to do |format|
      if @sku.update(sku_params)
        format.html { redirect_to admin_skus_path, notice: 'Sku was successfully updated.' }
        format.json { render :show, status: :ok, location: @sku }
      else
        format.html { render :edit }
        format.json { render json: @sku.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skus/1
  # DELETE /skus/1.json
  def destroy
    @sku.destroy
    respond_to do |format|
      format.html { redirect_to admin_skus_path, notice: 'Sku was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sku
    @sku = Sku.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sku_params
    params.require(:sku).permit(:name, :plan_id, :price, :interval, :description)
  end
end
