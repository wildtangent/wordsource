shared_examples 'a WordSource' do
  it "should be able to run continuously until wordsource is depleted" do
     source = WordSource.new
     source.should respond_to :run
  end

  it "should respond to next_word" do
     source = WordSource.new
     source.should respond_to :next_word!
  end

  it "should respond to top 5 consonants" do
     source = WordSource.new
     source.should respond_to :top_5_consonants
  end

  it "should respond to top 5 words" do
     source = WordSource.new
     source.should respond_to :top_5_words
  end

  it "should respond to count" do
     source = WordSource.new
     source.should respond_to :count
  end

  it "should respond to callback" do
     source = WordSource.new
     source.should respond_to :callback
  end
end