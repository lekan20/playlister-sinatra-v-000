require 'rack-flash'

class SongsController < ApplicationController

  get '/songs' do
    #shows all of the songs
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    #creates a new song without a new artist
    erb :'/songs/new'
  end

  post '/songs' do
    #posts the user inputs to the new song
    #params {"song_name"=>"Bad Company", "artist"=>{"name"=>"A$AP Rocky"}, "captures"=>[]}
    @song = Song.create(name: params["Name"])

    @song.artist = Artist.find_or_create_by(name: params["Artist Name"])

    @song.genre_ids = params[:genres]

    @song.save
    flash[:message] = "Successfully created song."

    redirect to("/songs/#{@song.slug}")

    # if !params["Artist Name"].empty?
    #   @song = Song.create(name: params["Name"], artist: Artist.find_or_create_by(name: params["Artist Name"]), genre_ids: params[:genres])
    # else
    #   @song = Song.create(name: params["Name"], artist: Artist.find(params["artist"]["id"]), genre_ids: params["genres"])
    # end
    # @song.save
    # flash[:message] = "Successfully created song."
    #
    # redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    #displays the song's artist and genre/s
    #params {"captures"=>[], "slug"=>"song"}
    @song = Song.find_by_slug(params["slug"])
    erb :'/songs/show'
  end


end
