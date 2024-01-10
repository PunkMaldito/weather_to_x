require 'bundler'

Bundler.require
Dotenv.load

class WeatherToX < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
  end

  configure :development do
    register Sinatra::Reloader
  end

  Dir.glob('./lib/*.rb') do |service|
    require service
  end

  post '/send_weather_tweet' do
    content_type :json

    wheater_info = WeatherRequest.new.get(api_key: ENV['WEATHER_API_KEY'],
                                          query: ERB::Util.url_encode(params[:query]))

    if SendTweet.call(payload: wheater_info)
      { message: 'Tweet posted!' }.to_json
    else
      halt 500, { message: 'Something very bad happen!' }.to_json
    end
  end
end
