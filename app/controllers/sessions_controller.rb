class SessionsController < ApplicationController


  def create
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        hash = spotify_user.to_hash
        redirect_to playlists_path(hash)

  end



end
