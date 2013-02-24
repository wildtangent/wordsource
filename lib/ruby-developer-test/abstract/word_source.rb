# WordSource class
# Provide basic abilities for iterating over array items and triggering callbacks  
# Example usage:
#  src = WordSource.new
#  src.words = ['foo','bar','baz','bang']
#  src.words.count = 4
#  src.top_5_consonants # => ['b', 'z', 'n', 'r', 'g']
#  src.next_word! # => 'foo'
#  src.next_word! # => 'bar'
class WordSource
  
  extend Callbacks
  
  callback :callback
  
  # The words that have been extracted from the given string
  attr_accessor :words
  
  @@vowels =  %w{a e i o u}
  @@consonants =  %w{b c d f g h j k l m n p q r s t v w x y z}
  
  # Initialize with current index
  def initialize
    @current = 0
  end
  
  # Step through all words
  def run
    words.each { next_word! }
  end
  
  # Get the next word from the array, run callbacks and step to the next one.
  def next_word!
    word = words[@current]
    callback(word)
    @current += 1 
    word
  end
  alias_method :next_word, :next_word!

  # Return the top 5 consonents
  def top_5_consonants
    consonants_in_words.top(5)
  end
  
  # Return the top 5 words
  def top_5_words
    words.top(5)
  end

  # Count the number of words in the source file
  def count
    words.count
  end

  # Find all the consonants in all the words
  def consonants_in_words
    words.join("").split("").select do |letter| 
      @@consonants.include?(letter)
    end 
  end
  
end
