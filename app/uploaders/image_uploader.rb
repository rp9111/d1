# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # :nocov:
  def store_dir
    "user_content/uploads/images/#{model.id}"
  end
  # :nocov:










  version :medium do
    process resize_to_fill: [640, 480]
  end




  # :nocov:
  def extension_white_list
    %w(jpg jpeg png)
  end
  # :nocov:

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

end
