require 'spec_helper'

describe LorumIpsumWordSource, "#WordSource" do

  let :source do
    LorumIpsumWordSource.new
  end
   
  it "should be able to run continuously until wordsource is depleted" do
     source.should respond_to :run
  end
  
  it "should respond to next_word" do
     source.should respond_to :next_word!
  end

  it "should respond to top 5 consonants" do
     source.should respond_to :top_5_consonants
  end

  it "should respond to top 5 words" do
     source.should respond_to :top_5_words
  end

  it "should respond to count" do
     source.should respond_to :count
  end

  it "should respond to callback" do
     source.should respond_to :callback
  end
  
  it 'should return "lorum"' do
    source.next_word!.should == "lorum" 
  end
end
