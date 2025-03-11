module MyChatbot
  class Consultant
    class << self
      def ask_question(question, locale='pt-BR')
        relevant_text = retrieve_relevant_text(question)

        response = MyChatbot.configuration.client.chat(
          parameters: {
            model: MyChatbot.configuration.model,
            messages: [
              { role: 'system', content: prompt(locale, relevant_text) },
              { role: 'user', content: "Question: #{question}" }
            ],
            max_tokens: 150
          }
        )

        response.dig("choices", 0, "message", "content")&.strip
      end

      def prompt(locale, relevant_text)
        "Please assume that you are a chatbot service and use the following document: #{relevant_text} to respond in the language: #{locale}. 
        \n\nThis way you cannot cite the document itself.
        \n\nRemember that because it is a chatbot you must answer questions related to the document, or at least close to it, if the question is not relevant, say that you cannot talk about it"
      end

      def retrieve_relevant_text(question)
        question_embedding = process_question(question)

        best_match = nil
        highest_similarity = -1

        redis.keys("embedding_*").each do |key|
          data = Marshal.load(redis.get(key))
          similarity = cosine_similarity(question_embedding, data[:vector])

          if similarity > highest_similarity
            highest_similarity = similarity
            best_match = data[:text]
          end
        end

        best_match
      end

      def process_question(question)
        MyChatbot::Processor.send_to_openai(question).dig("data", 0, "embedding")
      end

      def cosine_similarity(vec1, vec2)
        dot_product = vec1.zip(vec2).map { |a, b| a * b }.sum
        magnitude1 = Math.sqrt(vec1.map { |x| x**2 }.sum)
        magnitude2 = Math.sqrt(vec2.map { |x| x**2 }.sum)

        return 0 if magnitude1.zero? || magnitude2.zero?

        dot_product / (magnitude1 * magnitude2)
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end
