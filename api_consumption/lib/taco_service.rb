require 'faraday'
require 'faraday_middleware'
require 'pry'
require 'json'

class TacoService

  def random_ingredients
    get_json("/random")
  end

  def random_taco
    get_json("/random/?full-taco=true")
  end

  def contributions(username)
    get_json("/contributions/#{username}")
  end

  def ingredients_by_type(type)
    get_json("/contributors/#{type}")
  end

  def contributors_by_ingredient(type,ingredient)
    get_json("/contributors/#{type}/#{ingredient}")
  end

  private

  def get_json(uri)
    response = conn.get(uri)
    JSON.parse(response.body)
  end

  def conn
    @conn ||= Faraday.new(url: "http://taco-randomizer.herokuapp.com/") do |f|
      f.use FaradayMiddleware::FollowRedirects, limit: 5
      f.adapter Faraday.default_adapter
    end
  end
end
