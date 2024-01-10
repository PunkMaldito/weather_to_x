require 'sinatra/base'
require 'minitest/autorun'
require 'webmock/minitest'
require 'rack/test'

class TestApp < Minitest::Test
  describe '#POST' do
    include Rack::Test::Methods

    def app
      Class.new Sinatra::Base do
        post '/send_weather_tweet_with_location' do
          content_type :json

          { message: 'Tweet posted!' }.to_json
        end

        post '/send_weather_tweet_without_location' do
          content_type :json

          halt 500, { message: 'Something very bad happen!' }
        end
      end
    end

    def test_successul_post
      post('/send_weather_tweet_with_location',
                      query: 'Campo Grande')

      assert(last_response.ok?)
      assert_equal(last_response.status, 200)
      assert_equal('{"message":"Tweet posted!"}', last_response.body)
    end

    def test_failed_post
      post('/send_weather_tweet_without_location',
                      query: '')

      assert(!last_response.ok?)
      assert_equal(last_response.status, 500)
      assert_equal('{"message":"Something very bad happen!"}', last_response.body)
    end

    def test_no_route
      get('/')

      assert(last_response.not_found?)
      assert_equal(last_response.status, 404)
    end
  end
end
