require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'

class AdviceService
  def random
    response = conn.get "/advice"
    JSON.parse(response.body)
  end

  def search(keyword)
    response = conn.get "/advice/search/#{keyword}"
    JSON.parse(response.body)
  end

  private

  def conn
    @conn ||= Faraday.new(url: "https://api.adviceslip.com")
  end
end
