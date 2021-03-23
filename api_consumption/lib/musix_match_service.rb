require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'

class MusixMatchService

  def music_genres
    response = conn.get "ws/1.1/music.genres.get?apikey=#{ENV['MUSIXMATCH_API_KEY']}"
    JSON.parse(response.body)
  end

  def tracks_from_artist(artist)
    response = conn.get("/ws/1.1/track.search?q_artist=#{artist}&apikey=#{ENV['MUSIXMATCH_API_KEY']}")
    JSON.parse(response.body)
  end

  private

  def conn
    @conn ||= Faraday.new(url: "https://api.musixmatch.com")
  end
end
