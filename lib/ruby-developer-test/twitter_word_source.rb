require 'ruby-developer-test/twitter_client'

class TwitterWordSource < WordSource  

  attr_accessor :user, :term
  
  def initialize
    super
    @strategy = :user
  end
  
  # Initialize the class with a file and attribute for saving found words
  def strategy=(strategy)
    @strategy = :search
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
  
  # Return a search result from Twitter
  def twitter_search(term)
    TwitterClient.new.search(term)
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
  
  # Return a specified user from Twitter
  def twitter_user
    @twitter_user ||= TwitterClient.new.user(@user)
  end
  

  
end