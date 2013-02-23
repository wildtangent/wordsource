class Array  
  def frequency
    freqs = Hash.new(0)
    each { |word| freqs[word] += 1 }
    freqs.sort_by{|x,y| y}.reverse
  end
end

class LorumIpsumWordSource < WordSource
  
  attr_accessor :words, :found_words
  
  def initialize
    @words = File.open(file_path, "r+") do |file|
      file.read.split(",")
    end
    @current = 0
    @callbacks = []
    @found_words = []
  end

  def next_word!
    word = @words[@current]
    callback(word)
    @current += 1 
    word
  end
  
  def top_5_words
    frequency = @words.frequency
    0.upto(4).collect{|i| frequency[i][0] rescue nil}
  end
  
  def top_5_consonents
    vowels = %w{a e i o u}
    letters = @words.join("").split("").delete_if{|l| vowels.include?(l)} 
    frequency = letters.frequency
    #return frequency
    0.upto(4).collect{|i| frequency[i][0] rescue nil}
  end
  
  # Count the number of words in the source file
  def count
    @words.count
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
  
  # Wrapper for callback for on_found event
  def on_found(word)
    callback(word) do |current_word|
      if word == current_word
        @found_words << current_word
      end
    end
  end

  private
  def file_path
    @file_path = File.expand_path("./", file_name)    
  end
  
  def file_name
    "lorem_ipsum.txt"
  end
  
end