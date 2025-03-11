# MyChatbot

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add my_chatbot
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install my_chatbot
```

## Usage

### To start using the gem, you need to define some essential parameters for its functioning. 

For now, the gem only supports the OpenAI API, so you need to insert your personal token in `openai_api_key`. You can generate your own token at the [link](https://platform.openai.com/api-keys).

The next parameter will be responsible for informing the model that OpenAI will use to generate the responses for your chat (`model`), remembering that for generating embeddings the fixed model is `text-embedding-ada-002`.

And finally, to ensure correct usage, it is necessary to inform the path (`docs_path`) that the gem needs to follow until it finds its documentation, and thus be able to generate the embeddings.

Example:
```ruby
MyChatbot.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY']
  config.model = 'gpt-4o'
  config.docs_path = 'tmp/example.md'
end
```

As soon as the above configuration is executed in your initializer, the document embeddings will already be generated, and each time your initializer is executed again, the gem checks if the document has changed and then generates the embeddings based on the new information.

### Once the settings are correct, you can start consulting the chatbot, which will generate answers based on the document provided.

The AI ​​has been limited by prompts so that it only answers questions about the document, without being able to deviate from the main topic or answer random questions.

Usage example:
```ruby
MyChatbot::Consultant.ask_question(question)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/feliperodrigs1/my_chatbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/feliperodrigs1/my_chatbot/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MyChatbot project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/feliperodrigs1/my_chatbot/blob/master/CODE_OF_CONDUCT.md).
