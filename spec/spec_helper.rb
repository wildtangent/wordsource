require './lib/ruby-developer-test.rb'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

require 'vcr'
VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                  :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end
  
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.extend VCR::RSpec::Macros
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].downcase.gsub(/\W+/, "_").split("_", 2).join("/")
    VCR.use_cassette(name, :record => :new_episodes) do
      example.call
    end
  end
end
