ENV['RACK_ENV'] = 'test'

require './app'
require 'minitest/autorun'
require 'rack/test'

class TestApp < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_save_value
    post '/', submit: 'save', key: '2', cache_value: 'two'
    assert last_response.status == 200
    assert_match(/2/, last_response.body)
    assert_match(/two/, last_response.body)
  end

  def test_load_value
    post '/', submit: 'save', key: '2', cache_value: 'two'
    post '/', submit: 'load', key: '2'
    assert last_response.status == 200
    assert_match(/2/, last_response.body)
    assert_match(/two/, last_response.body)
  end
end
