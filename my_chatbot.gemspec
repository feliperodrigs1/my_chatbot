# frozen_string_literal: true

require_relative "lib/my_chatbot/version"

Gem::Specification.new do |spec|
  spec.name = "my_chatbot"
  spec.version = MyChatbot::VERSION
  spec.authors = ["Felipe Rodrigues"]
  spec.email = ["feliperodrigsp@gmail.com"]

  spec.summary = "WIP: Write a short summary, because RubyGems requires one."
  spec.description = "WIP: Write a longer description or delete this line."
  spec.homepage = "https://github.com/feliperodrigs1/my_chatbot"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_dependency "dotenv" 
  spec.add_dependency "ruby-openai"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
