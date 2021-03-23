require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'

class MusixMatchService

  def music_genres
    # response = conn.get "ws/1.1/music.genres.get?apikey=#{ENV['MUSIXMATCH_API_KEY']}"
    response = conn.get "ws/1.1/music.genres.get"
    JSON.parse(response.body)
  end

  def tracks_from_artist(artist)
    # response = conn.get("/ws/1.1/track.search?q_artist=#{artist}&apikey=#{ENV['MUSIXMATCH_API_KEY']}")
    # response = conn.get("/ws/1.1/track.search?q_artist=#{artist}")
    response = conn.get "/ws/1.1/track.search" do |f|
      f.params['q_artist'] = artist
    end
    JSON.parse(response.body)
  end

  private

  def conn
    @conn ||= Faraday.new(
      url: "https://api.musixmatch.com",
      params: { apikey: ENV['MUSIXMATCH_API_KEY'] }
    )
  end
end
