require 'spec_helper'
require 'support/shared_examples_for_wordsource'

describe TwitterWordSource do
  
  it_behaves_like 'a WordSource'

  let :source do
    TwitterWordSource.new
  end
  
  let :source_wildtangent do
    source.user = "wildtangent"
    source
  end
  
  let :source_search do
    source.strategy = :search
    source.term = "geckoboard"
    source
  end
  
  
  it 'should not have a user' do
    source.user.should be_nil
  end
  
  it 'should raise an exception if we try to get words when there is no user specified' do
    expect { source.top_5_words }.to raise_error
  end
  
  it 'should raise an exception if we try to get words when there is no search term specified' do
    expect { source.top_5_consonants }.to raise_error
  end
  
  it 'should set the user', :vcr do
    source_wildtangent.user.should == "wildtangent"
  end
  
  it 'should load words from a Twitter status', :vcr do
    source_wildtangent.words.should == ["Picture", "cannot", "hope", "to", "do", "justice", "to", "the", "skills", "this", "man", "has", "on", "the", "joanna!", "http://t.co/6cB0y53s"]
  end
    
  it 'should return the top 5 words', :vcr do
    source_wildtangent.top_5_words.should == ["to", "the", "skills", "has", "man"]
  end
  
  it 'should get words from a Twitter search', :vcr do
    source.twitter_search("geckoboard").statuses.should_not be_empty
  end
  
  it 'should return the top 5 words from a search', :vcr do
    source_search.top_5_words.compact.size.should == 5
  end
  
  # This spec would break if you delete the VCR cassette
  it 'should return the top 5 consonants from a search', :vcr do
    source_search.top_5_consonants.should == ["t", "n", "s", "r", "d"]
  end
  
  # This spec would break if you delete the VCR cassette
  it 'should return the top 5 words from a search', :vcr do
    source_search.top_5_words.should == ["@geckoboard", "the", "I", "to", "in"]
  end
  
  
end