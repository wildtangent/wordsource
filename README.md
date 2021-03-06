# Background

A WordSource is a source of words and it keeps analytical information of each word that it has seen.

# Configuration

Ensure you have a valid Twitter credentials YAML file in config/twitter.yml e.g.
```
twitter:
  consumer_key: MY_CONSUMER_KEY
  consumer_secret: MY_CONSUMER_SECRET
  oauth_token: MY_OAUTH_TOKEN
  oauth_token_secret: MY_OAUTH_TOKEN_SECRET
```

Create your Twitter access credentials on the [Twitter Developers Site](https://dev.twitter.com/apps/new)

You do NOT need to add your own Twitter credentials for the specs to pass, since they were mocked using my own credentials.   
However if you want to execute the code directly, then this would be necessary.
     
# Example

For the following string: "lorem ipsum ipsum"

```
src = LoremIpsumWordSource.new
src.next_word 
  # => "lorem"
src.next_word 
  # => "ipsum"
src.next_word 
  # => "ipsum"
src.top_5_words 
  # => ["ipsum","lorem",nil,nil,nil]
src.top_5_consonants 
  # => ["m","p","s","l","r"]
src.count 
  # => 3 # total words seen
```

# Assignment

1. Implement LoremIpsumWordSource
2. Get top 5 consonants from the words seen
3. Get top 5 words
4. Add callbacks on specific words e.g. every time "semper" is encountered, call those callbacks registered for "semper"
5. implement a WordSource that uses the Twitter API (instead of loading words from a file)

# Running Specs

Run the specs using 
```
rspec .
```

The specs will run using VCR cassettes to mock the Twitter requests.  
Due to the nature of live Twitter API calls, if the cassettes are deleted, some specs may begin to fail, as different results will be returned.

# Viewing Coverage

After running specs, coverage can be viewed under `coverage/rcov/index.html`

# Credits

* [Callbacks example](http://coderrr.wordpress.com/2008/11/22/super-simple-callbacks-in-ruby/)
* [VCR Gem](https://rubygems.org/gems/vcr)
* [Twitter Gem](https://github.com/sferik/twitter)
* [Simplecov](https://github.com/colszowka/simplecov)
* [SimpleCov-RCOV](https://github.com/fguillen/simplecov-rcov)
