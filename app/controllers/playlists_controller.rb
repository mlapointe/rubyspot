class PlaylistsController < ApplicationController

  def index

    # Rails.logger.info("PARAMS = #{params}")
    @suser = RSpotify::User.new(params)

    # @playlists = @suser.playlists #saved_tracks(limit:20)


    # PULL ALL SAVED TRACKS FROM SERVER
    @savedTracks = []
    offsetvar = 0
    tracks = @suser.saved_tracks(limit:50, offset:offsetvar)
    @savedTracks +=tracks

    lastPull = 0
    while tracks.count == 50 && lastPull == 0 do
      offsetvar +=50
      tracks = @suser.saved_tracks(limit:50, offset:offsetvar)
      @savedTracks += tracks
      if tracks.count <50
        lastPull = 1
      end
    end


    # CREATE LIST OF SAVED ARTISTS
    @savedArtists = []
    @savedTracks.each do |trac|
      @savedArtists.push(trac.artists.first.name)
    end
    @savedArtists = @savedArtists.uniq


  end


  def upload

  end


  def parsexml
    file = params[:uploaded_file][:uploaded_file]
    doc = Nokogiri::XML(open(file.path))

    @songnames = Array.new
    doc.xpath("/plist/dict[key='Tracks']/dict/dict/key[.='Name']/following-sibling::string[1]/node()").each do |n|
      @songnames.push(n)  #append data to array
    end

    @artistnames = Array.new
    doc.xpath("/plist/dict[key='Tracks']/dict/dict/key[.='Artist']/following-sibling::string[1]/node()").each do |n|
      @artistnames.push(n)  #append data to array
    end

    spotify_ids=[]

    @songnames.zip(@artistnames).each do |name, artist|
      #Step through and search for in
      tmptrack = RSpotify::Track.search(name)
      if tmptrack !=nil
        tmptrack.each do |trk|
          trk.artist == artist ? spotify_ids.push(trk.id) : nil
        end
      end
    end

    #save list of Song, Artist, ID information
    #create playlist on Spotify
    playlist = user.create_playlist!('NewPlaylistX')
    playlist.add_tracks!(RSpotify::Track.find(spotify_ids))

  end


end
