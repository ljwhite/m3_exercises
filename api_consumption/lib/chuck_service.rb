require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'

class ChuckService

  def random
    get_json("/jokes/random")
  end

  def random_in_category(category)
    get_json("/jokes/random?category=#{category}")
  end

  def categories
    get_json("/jokes/categories")
  end

  def search(query)
      get_json("jokes/search?query=#{query}")
  end

  private

  def get_json(uri)
    response = conn.get(uri)
    JSON.parse(response.body)
  end

  def conn
    @conn ||= Faraday.new(url: "https://api.chucknorris.io")
  end
end
