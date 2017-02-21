def mock_twitter_auth_hash
  # The mock_auth configuration allows you to set per-provider (or default)
  # authentication hashes to return during integration testing.
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => '12345',
    'info' => {
      'name' => 'mockuser',
      'image' => 'mock_user_thumbnail_url'
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  })
end

def mock_facebook_auth_hash
  # The mock_auth configuration allows you to set per-provider (or default)
  # authentication hashes to return during integration testing.
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    'provider' => 'facebook',
    'uid' => '12345',
    'info' => {
      'name' => 'mock user',
      'email' => 'mock@user.com',
      'image' => 'mock_user_thumbnail_url'
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  })
end

def mock_google_oauth2_auth_hash
  # The mock_auth configuration allows you to set per-provider (or default)
  # authentication hashes to return during integration testing.
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    'provider' => 'google_oauth2',
    'uid' => '12345',
    'info' => {
      'name' => 'mockuser',
      'email' => 'mock@user.com',
      'image' => 'mock_user_thumbnail_url'
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  })
end

def mock_instagram_auth_hash
  # The mock_auth configuration allows you to set per-provider (or default)
  # authentication hashes to return during integration testing.
  OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
    'provider' => 'instagram',
    'uid' => '12345',
    'info' => {
      'name' => 'mockuser',
      'email' => 'mock@user.com',
      'image' => 'mock_user_thumbnail_url'
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  })
end

