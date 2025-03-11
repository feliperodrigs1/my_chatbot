# frozen_string_literal: true

require_relative "my_chatbot/version"
require_relative "my_chatbot/configuration"
require_relative "my_chatbot/processor"
require_relative "my_chatbot/consultant"
require "dotenv"
require "redis"

Dotenv.load

module MyChatbot
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new

      if block_given?
        yield(configuration)

        MyChatbot::Processor.generate_embeddings
      end
    end
  end
end
