class Array  
  def frequency
    freqs = Hash.new(0)
    each { |word| freqs[word] += 1 }
    freqs.sort_by{|x,y| y}.reverse
  end
  
  # Return the top _n_ items from the array
  def top(n)
    items = self.frequency
    0.upto(n-1).collect{|i| items[i][0] rescue nil}
  end
  
end