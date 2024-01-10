# Weather To X
A simple Sinatra application that retrieves weather information and post on X.


## System Architecture

- [Sinatra](https://sinatrarb.com)


## Setup

```shell
bundle install
```

## Run

That will start your application at port 9292.

```shell
bundle exec rackup config.ru
```


## Endpoint

Exposes a POST endpoint that receives a city name or latitude and longitude as a query parameter.

Example:

```shell
curl -d "query=São Paulo" -X POST "http://localhost:9292/send_weather_tweet"
```
or
```shell
curl -d "query=-20.4435,-54.6478" -X POST "http://localhost:9292/send_weather_tweet"
```
