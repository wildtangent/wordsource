class Array  
  def frequency
    freqs = Hash.new(0)
    each { |word| freqs[word] += 1 }
    freqs.sort_by{|x,y| y}.reverse
  end
end

class LorumIpsumWordSource < WordSource
  
  attr_accessor :source
  
  def initialize
    @source = File.open(file_path, "r+") do |file|
      file.read.split(",")
    end
    @current = 0
  end

  def next_word!
    word = @source[@current]
    @current += 1 
    word
  end
  
  def top_5_words
    frequency = @source.frequency
    0.upto(4).collect{|i| frequency[i][0] rescue nil}
  end
  
  def top_5_consonents
    vowels = %w{a e i o u}
    letters = @source.join("").split("").delete_if{|l| vowels.include?(l)} 
    frequency = letters.frequency
    #return frequency
    0.upto(4).collect{|i| frequency[i][0] rescue nil}
  end
  
  # Count the number of words in the source file
  def count
    @source.count
  end

  private
  def file_path
    @file_path = File.expand_path("./", file_name)    
  end
  
  def file_name
    "lorem_ipsum.txt"
  end
  
end