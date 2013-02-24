class TwitterClient
  
  class NoUserException < Exception;end;
  class NoSearchTermException < Exception;end;
  class ReachedMaximumRetriesException < Exception;end;
  
  require 'twitter'
  
  @@max_attempts = 3
  
  def client
    @client ||= Twitter::Client.new(
      consumer_key: "rizxIZ5tWC8TEUNElLD8Cw",
      consumer_secret: "9F0rSBayH73x6J0dmyxtNvokl59Yv1yjoCf33bs",
      oauth_token: "7256962-88V7NhDNtqADDXAbQBqiU09jmwMZwL1aDhjiP9yU",
      oauth_token_secret: "oJiMVAHJehXtp54aEFFv2wRY6iIycs5lOKER3LNo"
    )
  end
  
  # Perform a search
  def search(term)
    raise NoSearchTermException, "No search term specified" if term.nil?
    num_attempts = 0
    begin
      num_attempts += 1
    client.search(term)
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= @@max_attempts
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        puts "Rate limited! Will retry in #{error.rate_limit.reset_in} seconds"
        sleep error.rate_limit.reset_in
        retry
      else
        raise ReachedMaximumRetriesException, "Can't try any more attempts"
      end
    end    
  end
  
  # Fetch a specified user
  def user(user)
    raise NoUserException, "No user specified" if user.nil?
    num_attempts = 0
    begin
      num_attempts += 1      
      client.user(user)
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= @@max_attempts
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        puts "Rate limited! Will retry in #{error.rate_limit.reset_in} seconds"
        sleep error.rate_limit.reset_in
        retry
      else
        raise ReachedMaximumRetriesException, "Can't try any more attempts"
      end
    end
  end
  
end