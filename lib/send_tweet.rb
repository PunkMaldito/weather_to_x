class SendTweet
  X_CREDENTIALS = {
    api_key: ENV['X_API_KEY'],
    api_key_secret: ENV['X_API_KEY_SECRET'],
    access_token: ENV['X_ACCESS_TOKEN'],
    access_token_secret: ENV['X_ACCESS_TOKEN_SECRET']
  }

  def self.call(...)
    new(...).call
  end

  def initialize(payload:)
    @payload = payload
    @x_client = X::Client.new(**X_CREDENTIALS)
  end

  def call
    return false if @payload.nil?

    message = create_message(@payload)
    @x_client.post('tweets', { text: message }.to_json)

    true
  end

  protected

  def create_message(payload)
    "#{payload[:current][:temperature]}°C e #{payload[:current][:condition]} em #{payload[:city]} em #{payload[:current][:date]}. "\
    "Média para os próximos dias: #{payload[:forecast].map { |f| "#{f[:temperature]}°C em #{f[:date]}"}.join(', ') }."
  end
end
