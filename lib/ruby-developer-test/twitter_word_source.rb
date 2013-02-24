# TwitterWordSource class  
# Implement WordSource class, adding Twitter API capabilities
# Example usage:
#  src = TwitterWordSource.new
#  src.user = "geckoboard"
#  src.next_word! # => "geckoboard"
#  src.next_word! # => "dashboard"
#  src.next_word! # => "awesome"
class TwitterWordSource < WordSource 
   
  require 'ruby-developer-test/twitter_client'

  # Set the user and search term
  attr_reader :user, :term
  
  # Initialize class, and set default strategy to :user
  def initialize
    super
    @strategy = :user
  end
  
  # Set the Twitter lookup strategy to :search or :user
  def strategy=(strategy)
    case strategy
    when :user, :search
      @strategy = strategy
    end
  end
  
  # Set the Twitter user to find
  def user=(user)
    @user = user
    @twitter_user = nil
    load_words
  end
  
  # Set the Twitter user to find
  def term=(term)
    @term = term
    @twitter_search = nil
    load_words
  end
  
  private
  
  # Get the words from the file 
  def load_words
    case @strategy
    when :user
      @words = twitter_user.status.text.split(/\s/)  
    when :search
      @words = twitter_search(@term).statuses.map(&:text).join(" ").split(/\s/)
    end
  end
  
  # Return a search result from Twitter
  def twitter_search(term)
    TwitterClient.new.search(term)
  end
  
  # Return a specified user from Twitter
  def twitter_user
    @twitter_user ||= TwitterClient.new.user(@user)
  end
  

  
end