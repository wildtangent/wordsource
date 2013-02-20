class WordSource
  def run
    raise NotImplementedError, "You should implement this method"
  end
  
  def next_word!
    raise NotImplementedError, "You should implement this method"
  end

  def top_5_consonants
    raise NotImplementedError, "You should implement this method"
  end
  
  def top_5_words
    raise NotImplementedError, "You should implement this method"
  end

  def count 
    raise NotImplementedError, "You should implement this method"
  end

  def callback
    raise NotImplementedError, "You should implement this method"
  end
end
