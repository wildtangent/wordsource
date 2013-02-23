require 'ruby-developer-test/twitter_client'

class TwitterWordSource < WordSource  

  attr_accessor :user
  
  # Initialize the class with a file and attribute for saving found words
  def initialize
    super
  end
  
  def user=(user)
    @user = user
    @twitter_user = nil
    load_words
  end
  
  
  private
  
  # Get the words from the file 
  def load_words
    @words = twitter_user.status.text.split(/\s/)  
  end
  
  # Return a specified user from Twitter
  def twitter_user
    @twitter_user ||= TwitterClient.new.fetch(@user)
  end
  
  # Return a search result from Twitter
  
  
end