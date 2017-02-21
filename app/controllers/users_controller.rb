class UsersController < ApplicationController
  layout 'profile'

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = request.env['omniauth.identity']
  end

  # GET /users/1/edit
  def edit
    redirect_to root_url unless current_user
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_name: params[:user_name], email: params[:email], password: params[:password])
    @user.admin = User.all.empty?
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    # NotificationMailer.confirm_account(@user).deliver_now unless @user.confirmed
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = current_user
    sign_out
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def deactivate
    @user = current_user || User.new
    if params[:confirm].present? 
      if @user.cancel_subscription
        redirect_to root_url, notice: 'Your subscription has been canceled and will not be charged again. You have access until the end of this billing cycle.'
      else
        redirect_to root_url, notice: 'There was no subscription to delete.'
      end
    else
      render 'deactivate'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password, :first_name, :last_name, :user_name, :email, :avatar, :stripe_token, :bio)
  end
end
