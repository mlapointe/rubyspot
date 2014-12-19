class HomeController < ApplicationController

  def index
    RSpotify.authenticate("2e400e64a6304722adc3d9b33bef90d2", "0eea6df8cd134bdca8dffc5c12c2b71f")

    # favAlbums = RSpotify::Playlist.find('121713874', '6CyzKvXaJrsApvnRG8xx1s')
    favAlbums = RSpotify::Playlist.find('spotify', '1yHZ5C3penaxRdWR7LRIOb')

    @favAlbum = favAlbums.tracks.uniq{|x| x.album.name}



  end


  def createModal

    trackID = params['track']
    Rails.logger.info("TRACKID = #{trackID}")
    albumNum = params['album']
    track = RSpotify::Track.find(trackID)

    ## RETURN HTML FOR .modal_body

    respond_to do |format|
      format.html { render partial: 'shared/albumModal', locals: { track: track}}
    end

  end



end
