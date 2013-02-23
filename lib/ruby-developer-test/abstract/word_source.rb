class WordSource
  
  attr_accessor :words
  
  def initialize
    @current = 0
    @callbacks = []
    @vowels = %w{a e i o u}
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

  # Return the top 5 consonents
  def top_5_consonants
    consonants.top(5)
  end
  
  # Return the top 5 words
  def top_5_words
    words.top(5)
  end

  # Count the number of words in the source file
  def count
    words.count
  end
  
  # Basic callback pattern
  def callback(*args, &block)
    if block
      @callbacks << block
    elsif @callbacks
      @callbacks.each do |callback|
        callback.call(*args)
      end
    end
  end

  def consonants
    words.join("").split("").delete_if{|letter| @vowels.include?(letter)} 
  end
  
end
