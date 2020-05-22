# frozen_string_literal: true

require_relative "helper"

class TestCountry < Minitest::Test
  def test_all
    countries = Gwitch::Country.all
    refute_empty countries
  end

  def test_avaliable?
    assert_equal Gwitch::Country.avaliable?('US'), true
    assert_equal Gwitch::Country.avaliable?('FOO'), false
  end

  def test_attributes
    country = Gwitch::Country.new('US')

    assert_equal country.alpha2, 'US'
    assert_equal country.region, 'Americas'
    assert_equal country.currency, 'USD'
  end
end