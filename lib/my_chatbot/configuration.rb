require "openai"

module MyChatbot
  class Configuration
    attr_accessor :openai_api_key, :docs_path, :model

    def initialize ; end

    def client
      return @client if defined?(@client)

      opts = { access_token: openai_api_key }
      opts.merge!(log_errors: true) if defined?(Rails) && Rails.env.development?

      @client = OpenAI::Client.new(opts)
    end
  end
end
