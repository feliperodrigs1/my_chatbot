module MyChatbot
  class Processor
    class << self
      def generate_embeddings
        raise 'Path not defined' unless MyChatbot.configuration.docs_path

        cached_document = redis.get('chatbot_document')
        document = MyChatbot::FileReader.call

        if cached_document.nil? || cached_document != document
          puts 'Generating embeddings...'

          delete_old_embeddings

          document.split("\n\n").each_with_index do |section, index|
            response = send_to_openai(section)
            vector = response.dig("data", 0, "embedding")
  
            redis.set("embedding_#{index}", Marshal.dump({ text: section, vector: vector }))
          end
  
          redis.set('chatbot_document', document)
        end

        puts 'Embeddings processed!'
      end

      def delete_old_embeddings
        keys = redis.keys("embedding_*")
        redis.del(*keys) unless keys.empty?
      end

      def send_to_openai(text)
        MyChatbot.configuration.client.embeddings(
          parameters: {
            model: 'text-embedding-ada-002',
            input: text
          }
        )
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end
