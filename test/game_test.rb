# frozen_string_literal: true

require "open-uri"
require_relative "helper"

class TestGame < Minitest::Test
  REGIONS ||= %w[Americas Asia Europe].freeze
  MAX_ERROR_CNT = 50

  def setup
    @games = Gwitch::Game.all
  end

  def test_all
    assert_equal @games.keys, REGIONS
    REGIONS.each do |region|
      refute_empty @games[region]
    end
  end

  def test_price
    alpha2 = 'US'
    nsuid = '70010000000141'

    refute_nil Gwitch::Game.price(alpha2, nsuid)
  end

  def test_urls
    urls = []
    @games.values.flatten.each do |game|
      urls += game[:images]
      urls << game[:url] if game[:url]
    end
    
    cnt = 0
    urls.each do |url|
      uri = URI.parse(url)

      assert uri.is_a?(URI::HTTP)
      refute_nil uri.host

      URI.open(uri)
    end
  rescue OpenURI::HTTPError
    cnt += 1
    assert cnt < MAX_ERROR_CNT
  end
end