

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "2e400e64a6304722adc3d9b33bef90d2", "0eea6df8cd134bdca8dffc5c12c2b71f", scope: 'user-read-email user-read-private playlist-read-private playlist-modify-public user-library-read user-library-modify'
end
