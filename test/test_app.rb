require 'sinatra/base'
require 'minitest/autorun'
require 'webmock/minitest'
require 'rack/test'
require 'x'

class TestApp < Minitest::Test
  describe '#POST' do
    include Rack::Test::Methods

    def app
      Sinatra::Application
    end

    def test_successul_post
    end

    def test_failed_post
    end
  end
end
