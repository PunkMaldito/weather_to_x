require 'minitest/autorun'
require 'webmock/minitest'
require './lib/send_tweet.rb'
require 'x'

class TestSendTweet < Minitest::Test
  def test_call_without_payload
    subject = SendTweet.call(payload: nil)
    assert_equal(subject, false)
  end

  def test_success_call
    stub_request(:get, 'http://api.weatherapi.com/v1/forecast.json?days=6&aqi=no&alerts=no&lang=pt&key=1&q=Campo Grande')
      .to_return(status: 200, body: weather_info, headers: { 'Content-Type' => 'application/json' })

    stub_request(:post, "https://api.twitter.com/2/tweets")
      .with(
        body: "{\"text\":\"33,0°C e parcialmente nublado em Campo Grande em 09/01. "\
              "Média para os próximos dias: 30,4°C em 10/01, 28,4°C em 11/01, 26,8°C em 12/01, 26,9°C em 13/01, 27,2°C em 14/01.\"}",
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'',
          'Content-Type'=>'application/json; charset=utf-8',
          'Host'=>'api.twitter.com',
          'User-Agent'=>'X-Client/0.14.1 ruby/3.2.2 (x86_64-linux)'
        }).to_return(status: 200, body: "", headers: {})

    subject = SendTweet.call(payload: weather_info)
    assert_equal(subject, true)
  end

  def weather_info
    {
      city: 'Campo Grande',
      current: {
        date: '09/01',
        temperature: '33,0',
        condition: 'parcialmente nublado'
      },
      forecast: [
        { date: '10/01', temperature: '30,4' },
        { date: '11/01', temperature: '28,4' },
        { date: '12/01', temperature: '26,8' },
        { date: '13/01', temperature: '26,9' },
        { date: '14/01', temperature: '27,2' }
      ]
    }
  end
end
