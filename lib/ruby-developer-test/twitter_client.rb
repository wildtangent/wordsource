class TwitterClient
  
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
    fetch.search(term)
  end
  
  # Fetch a specified user
  def user(user)
    raise Exception, "No user specified" if user.nil?

    fetch.user(user)
  end
  
  # Just initialize the client
  def fetch
    num_attempts = 0
    begin
      num_attempts += 1
      return client
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= @@max_attempts
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        puts "Rate limited! Will retry in #{error.rate_limit.reset_in} seconds"
        sleep error.rate_limit.reset_in
        retry
      else
        raise
      end  
    end
  end
  
end