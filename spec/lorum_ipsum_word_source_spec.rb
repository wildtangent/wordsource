require 'spec_helper'
require 'support/shared_examples_for_wordsource'

describe LorumIpsumWordSource do

  it_behaves_like 'a WordSource'

  let :source do
    LorumIpsumWordSource.new
  end
  
  it 'should return "Lorem"' do
    source.next_word!.should == "Lorem" 
  end
  
  it 'should return "ipsum"' do
    source.next_word!
    source.next_word!.should == "ipsum"     
  end
  
  it 'should return "dolor"' do
    source.next_word!
    source.next_word!
    source.next_word!.should == "dolor"
  end
  
  it 'should return the top 5 words' do
    source.words = %w{lorem ipsum ipsum}
    source.top_5_words.should == ["ipsum", "lorem", nil, nil, nil]
  end
  
  it 'should return the top 5 words from the file source' do
    source.top_5_words.should == ["vel", "sed", "vitae", "et", "in"]    
  end
  
  it 'should return the count of all the words' do
    source.words = %w{lorem ipsum ipsum}
    source.count.should == 3
  end
  
  it 'should return the count of all the words' do
    source.count.should == 4946
  end
  
  it 'should return the top 5 consonants' do
    source.words = %w{lorem ipsum ipsum}
    source.top_5_consonants.should == ["m","s","p","r","l"]    
  end
  
  it 'should fire a callback when the word "semper" is seen' do
    source.on_found("semper")
    source.words.each do
      source.next_word!
    end
    source.found_words.should include("semper")
  end
  
  it 'should fire a callback when the words "semper" and "Lorem" are seen' do
    source.on_found("semper")
    source.on_found("Lorem")
    source.run
    source.found_words.should include("semper")
    source.found_words.should include("Lorem")
  end
  
  it 'should not add the word "ipsum" to the found_words list' do
    source.on_found("semper")
    source.on_found("Lorem")
    source.run
    source.found_words.should_not include("ipsum")
  end


end
