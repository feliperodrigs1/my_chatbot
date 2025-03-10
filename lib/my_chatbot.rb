# frozen_string_literal: true

require "my_chatbot/version"
require "my_chatbot/configuration"
require "my_chatbot/processor"
require "my_chatbot/consultant"

module MyChatbot
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new

      yield(configuration) if block_given?
    end
  end
end
