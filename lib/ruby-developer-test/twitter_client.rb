class TwitterClient
  
  extend Callbacks
  
  class NoUserException < Exception;end;
  class NoSearchTermException < Exception;end;
  class ReachedMaximumRetriesException < Exception;end;
  
  require 'twitter'
  require 'yaml'
  require 'active_support/core_ext/hash'
  
  @@max_attempts = 3
  
  # Perform a search against the Twitter API
  def search(term)
    raise NoSearchTermException, "No search term specified" if term.nil?
    connection do
      client.search(term)
    end 
  end
  
  # Fetch a specified user from the Twitter API
  def user(user)
    raise NoUserException, "No user specified" if user.nil?
    connection do
      client.user(user)
    end
  end
  
  # Array to track any connection errors
  def errors
    @errors ||= []
  end
  
  def clear_errors!
    @errors = []
  end
  
  private
  
  # Try a connection to the Twitter API. Rescue and retry if rate limited
  def connection
    clear_errors!
    num_attempts = 0
    begin
      num_attempts += 1
      yield
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= @@max_attempts
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        errors << "Rate limited! Will retry in #{error.rate_limit.reset_in} seconds"
        sleep error.rate_limit.reset_in
        retry
      else
        raise ReachedMaximumRetriesException, "Can't try any more attempts"
      end
    rescue Twitter::Error => error
      errors << "Error accessing the Twitter API. Please try later"
    end
  end
  
  # Build a client connection using the Twitter gem
  def client
    @client ||= Twitter::Client.new(client_config)
  end
  
  def client_config
    YAML.load_file(File.expand_path("./config/twitter.yml"))["twitter"].symbolize_keys!
  end
  
  
end