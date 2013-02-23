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
    @found_words = []
    on_found do |word|
      @found_words << word 
    end
  end

  def next_word!
    word = @words[@current]
    on_found(word)
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
  
  def on_found(*args, &block)
    if block
      @on_found = block
    elsif @on_found
      @on_found.call(*args)
    end
  end
  
  def callback(word)
    puts word
    found_words << word if word == "semper"
    yield word == "semper" ? true : false 
  end

  private
  def file_path
    @file_path = File.expand_path("./", file_name)    
  end
  
  def file_name
    "lorem_ipsum.txt"
  end
  
end