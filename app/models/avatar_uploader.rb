# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # :nocov:
  def store_dir
    "user_content/avatars/#{model.user_name[0..1]}/#{model.user_name}"
  end
  # :nocov:

  def default_url
    result = '/images/avatar.png'
    if model.email.present?
      hash = Digest::MD5.hexdigest(model.email)
      result = "http://www.gravatar.com/avatar/#{hash}?d=identicon"
    end
    result
  end

  version :medium do
    process resize_to_fill: [640, 640]
  end
  version :small, from: :medium do
    process resize_to_fill: [120, 120]
  end

  # :nocov:
  def extension_white_list
    %w(jpg jpeg png)
  end
  # :nocov:

  def filename
    "#{model.user_name}.#{file.extension}" if original_filename.present?
  end

end
