require "openai"

module MyChatbot
  class Configuration
    attr_accessor :openai_api_key, :docs_path, :model

    def initialize
      @openai_api_key = ENV["OPENAI_API_KEY"]
    end

    def client
      return @client if defined?(@client)

      @client = OpenAI::Client.new(access_token: @openai_api_key)

      @client.merge!(log_errors: true) if defined?(Rails) && Rails.env.development?
    end
  end
end
