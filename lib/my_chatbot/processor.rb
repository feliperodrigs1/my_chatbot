module MyChatbot
  class Processor
    class << self
      def generate_embeddings
        raise 'Path not defined' unless MyChatbot.configuration.docs_path

        cached_document = redis.get('chatbot_document')
        document = File.read(MyChatbot.configuration.docs_path)

        if cached_document && cached_document != document
          response = send_to_openai(document)
          vectors  = response.dig('data', 0, 'embedding')
  
          redis.set('chatbot_document', document)
          redis.set('chatbot_embeddings', vectors)
        end
      end

      def send_to_openai(document)
        MyChatbot.configuration.client.embeddings(
          parameters: {
            model: 'text-embedding-ada-002',
            input: document
          }
        )
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end
