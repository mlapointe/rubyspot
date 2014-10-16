class PlaylistsController < ApplicationController

  def index

    # Rails.logger.info("PARAMS = #{params}")
    @suser = RSpotify::User.new(params)

    @playlists = @suser.playlists #saved_tracks(limit:20)

  end


end
