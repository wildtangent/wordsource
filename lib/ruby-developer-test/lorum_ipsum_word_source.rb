class LorumIpsumWordSource < WordSource
  
  attr_accessor :file, :source
  
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

  private
  def file_path
    @file_path = File.expand_path("./", file_name)    
  end
  
  def file_name
    "lorem_ipsum.txt"
  end
  
end