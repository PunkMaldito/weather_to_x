# Weather To X
A simple Sinatra aplication that retrieves weather information and post on X.


## System Architecture

- [Sinatra](https://sinatrarb.com)


## Setup

```shell
bundle install
```

## Run

```shell
bundle exec rackup config.ru
```
That will start your application at port 9292.


## Endpoint

Exposes a POST endpoint that receives a city name or latitude and longitude as a query parameter.

Example:

```shell
curl -d "query=São Paulo" -X POST "http://localhost:9292/send_weather_tweet"
```
