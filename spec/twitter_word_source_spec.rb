require 'spec_helper'

describe LorumIpsumWordSource do

  let :source do
    TwitterWordSource.new
  end
  
  let :source_wildtangent do
    source.user = "wildtangent"
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
  
end