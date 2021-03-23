require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'
require 'digest'

class MarvelService

  def character(name)
    response = conn.get("/v1/public/characters") do |f|
      f.params['name'] = name
    end
    JSON.parse(response.body)
  end

  def creators(name)
    last_name = name[:last_name]
    first_name = name[:first_name]
    response = conn.get("/v1/public/creators") do |f|
      f.params['lastName'] = last_name if first_name.nil?
      f.params['firstName'] = first_name if last_name.nil?
    end
    JSON.parse(response.body)
  end

  private

  def conn
    @conn ||= Faraday.new(
      url: "https://gateway.marvel.com",
      params: {
        apikey: ENV["MARVEL_PUBLIC_KEY"],
        ts: timestamp,
        hash: hash_digest
      }
    )
  end

  def timestamp
    Time.now.to_i
  end

  def hash_digest
    private = ENV['MARVEL_PRIVATE_KEY']
    public = ENV["MARVEL_PUBLIC_KEY"]
    Digest::MD5.hexdigest(timestamp.to_s + private + public)
  end
end
