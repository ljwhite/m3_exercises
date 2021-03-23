require 'spec_helper'
# require './musix_match_service'

describe MusixMatchService do
  before(:each) do
    @m = MusixMatchService.new
  end

  it 'exists' do
    expect(@m).to be_a(MusixMatchService)
  end

  it 'can find a list of music genres' do
    response = @m.music_genres

    expect(response).to have_key("message")
    expect(response["message"]).to have_key("body")
    expect(response["message"]["body"]).to have_key("music_genre_list")
    expect(response["message"]["body"]["music_genre_list"]).to be_an(Array)
  end

  it 'can find a list of tracks by an artist search' do
    response = @m.tracks_from_artist("NEEDTOBREATH")

    expect(response).to have_key("message")
    expect(response["message"]).to have_key("body")
    expect(response["message"]["body"]).to have_key("track_list")
    expect(response["message"]["body"]["track_list"][0]).to have_key("track")
    expect(response["message"]["body"]["track_list"][0]["track"]).to have_key("artist_name")
    expect(response["message"]["body"]["track_list"][0]["track"]).to have_key("track_name")
  end

end
