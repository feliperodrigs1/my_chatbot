module MyChatbot
  class Processor
    class << self
      def generate_embeddings
        raise 'Path not defined' unless MyChatbot.configuration.docs_path

        document = File.read(MyChatbot.configuration.docs_path)
        response = send_to_openai(document)

        redis = Redis.new
        vectors = response.dig("data", 0, "embedding")

        redis.set("chatbot_embeddings", vectors)
      end

      def send_to_openai(document)
        MyChatbot.configuration.client.embeddings(
          parameters: {
            model: "text-embedding-ada-002",
            input: document
          }
        )
      end
    end
  end
end
