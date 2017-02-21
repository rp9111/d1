class UploadsController < ApplicationController

  def create
    @upload = Upload.new user: current_user, attachment: params[:file].tempfile
    if @upload.save
      render json: @upload
    else
      render json: { errors: @upload.errors.full_messages }, status: 422
    end
  end

end
