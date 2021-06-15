ENV['RACK_ENV'] = 'test'

require 'json'
require 'minitest/autorun'
require 'rack/test'
require_relative './main'

class MainAppTest < Minitest::Test
  include Rack::Test::Methods 

  def app
    Sinatra::Application
  end

  def test_square_local
    ans = square(12)
    expected_ans = 144
    assert_equal(ans, expected_ans)
  end

  def test_square
    get '/?x=12'
    act_response = JSON.parse(last_response.body)
    exp_response = { error: "", x: 12, answer: 144 }.to_json
    assert last_response.ok?
    assert_equal(act_response, JSON.parse(exp_response))
  end

  def test_square_no_x
    get '/'
    act_response = JSON.parse(last_response.body)
    exp_response = { error: "Param x is missing" }.to_json
    assert last_response.ok?
    assert_equal(last_response.body, exp_response)
  end

  def test_square_x_empty
    get '/?x='
    act_response = JSON.parse(last_response.body)
    exp_response = { error: "Param x is missing" }.to_json
    assert last_response.ok?
    assert_equal(last_response.body, exp_response)
  end

  def test_square_x_not_int
    get '/?x=the'
    act_response = JSON.parse(last_response.body)
    exp_response = { error: "Param x is not an integer" }.to_json
    assert last_response.ok?
    assert_equal(last_response.body, exp_response)
  end
end