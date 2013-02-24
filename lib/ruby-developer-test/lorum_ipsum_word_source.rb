# LorumIpsumWordSource class  
# Implement WordSource class, adding file loading capabilities and adding custom callback for _on_found_
# Example usage:
#  src = LorumIpsumWordSource.new
#  src.on_found("semper")
#  src.run
#  src.found_words == ['semper','semper','semper']...
class LorumIpsumWordSource < WordSource
  
  # Accessor returing all words which were found during the :on_found callback
  attr_accessor :found_words
  
  # Initialize the class with a file and attribute for saving found words
  def initialize
    super
    load_words
    @found_words = []
  end
  
  # Get the words from the file 
  def load_words
    @words = File.open(file_path, "r+") do |file|
      file.read.split(",")
    end
  end

  # # Wrapper for callback for on_found event
  def on_found(word)
    callback(word) do |current_word|
      if word == current_word
        @found_words << current_word
      end
    end
  end
  
  private

  # Expand file path from current path
  def file_path
    @file_path ||= File.expand_path("./", file_name)    
  end
  
  # Default filename
  def file_name
    @file_name ||= "lorem_ipsum.txt"
  end
  
end