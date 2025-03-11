require 'pdf-reader'

module MyChatbot
  class FileReader
    class << self
      SUPPORTED_FORMATS = %w[md pdf].freeze

      def call
        ext = File.extname(document_path).delete('.').downcase

        unless SUPPORTED_FORMATS.include?(ext)
          raise "Unsupported file format: .#{ext}"
        end
  
        send("read_#{ext}")
      end

      def read_md
        File.read(document_path)
      end

      def read_pdf
        reader = PDF::Reader.new(document_path)

        reader.pages.map(&:text).join("\n").gsub(/\r?\n/, "\n\n").strip
      end

      def document_path
        @document_path ||= MyChatbot.configuration.docs_path
      end
    end
  end
end
