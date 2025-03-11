require 'pdf-reader'

module MyChatbot
  class FileReader
    SUPPORTED_FORMATS = %w[md pdf txt].freeze

    class << self
      def call
        ext = File.extname(document_path).delete('.').downcase

        unless SUPPORTED_FORMATS.include?(ext)
          raise "Unsupported file format: .#{ext}"
        end
  
        send("read_#{ext}").strip
      end

      %w(md txt).each do |ext|
        define_method("read_#{ext}") do
          File.read(document_path)
        end
      end

      def read_pdf
        reader = PDF::Reader.new(document_path)

        reader.pages.map(&:text).join("\n")
      end

      def document_path
        @document_path ||= MyChatbot.configuration.docs_path
      end
    end
  end
end
