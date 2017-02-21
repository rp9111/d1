CarrierWave.configure do |config|
  if Rails.env == 'production1'
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('AWS_BUCKET_NAME')
    config.aws_acl    = ENV.fetch('AWS_ACL')

    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    config.aws_credentials = {
       access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
       secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
       region:            ENV.fetch('AWS_REGION')
     }
  else
    config.storage    = :file
  end

end
