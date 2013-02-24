# Extends the Array class to include frequency and top(n) items
module ArrayFrequencyExtensions 
  
  # Build a hash of items in the Array and their number of occurances 
  # and return it sorted in descending order
  def frequency
    freqs = Hash.new(0)
    each { |word| freqs[word] += 1 }
    freqs.sort_by{|x,y| y}.reverse
  end
  
  # Return the top _n_ items from the Array
  def top(n)
    items = self.frequency
    0.upto(n-1).collect{|i| items[i][0] rescue nil}
  end
  
end

# Inject the extensions into the Array class
Array.send(:include, ArrayFrequencyExtensions)