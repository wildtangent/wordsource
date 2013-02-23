require 'spec_helper'

describe TwitterWordSource do

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
  
  it 'should set the user' do
    source_wildtangent.user.should == "wildtangent"
  end
  
  it 'should load words from a Twitter status' do
    source_wildtangent.words.should == ["Picture", "cannot", "hope", "to", "do", "justice", "to", "the", "skills", "this", "man", "has", "on", "the", "joanna!", "http://t.co/6cB0y53s"]
  end
    
  it 'should return the top 5 words' do
    source_wildtangent.top_5_words.should == ["to", "the", "skills", "has", "man"]
  end
  
  it 'should get words from a Twitter search' do
    source.twitter_search("geckoboard").statuses.should_not be_empty
  end
  
  it 'should get words from a Twitter search' do
    source.twitter_search("geckoboard").statuses.should_not be_empty
  end
  
  it 'should return the top 5 words from a search' do
    source_search.top_5_words.compact.size.should == 5
  end
  
end