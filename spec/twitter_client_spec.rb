require 'spec_helper'

describe TwitterClient do
  
  let :twitter_client do
    TwitterClient.new
  end
  
  let :user do
    "wildtangent"
  end

  let :term do
    "geckoboard"
  end

  let :status do
    "Picture cannot hope to do justice to the skills this man has on the joanna! http://t.co/6cB0y53s"
  end
    
  let :rate_limit_exception do
    exception = Twitter::Error::TooManyRequests.new
    exception.rate_limit.update({
      'x-rate-limit-limit' => 350, 
      'x-rate-limit-reset' => (Time.now.to_i + 2) 
    })
    exception
  end
  
  it 'should have some valid Twitter config' do
    twitter_client.send(:client_config).keys.should include(:consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret)
  end
  
  it 'should clear existing errors' do
    twitter_client.errors << "Sorry, but something went wrong"
    twitter_client.clear_errors!
    twitter_client.errors.should == []
  end
  
  it 'should load the specified users feed', :vcr do
    twitter_client.user(user).should be_kind_of(Twitter::User)
  end
  
  it 'should have the users name', :vcr do
    twitter_client.user(user).name == "Joe Connor"
  end

  it 'should get the users status', :vcr do
    twitter_client.user(user).status.text.should == status
  end
  
  it 'should get a set of search results', :vcr do
    twitter_client.search("bbc").statuses.should_not be_empty
  end
  
  it 'should try to reconnect if the Twitter client is rate limited while calling user', :vcr do
    twitter_client.send(:client).should_receive(:user).with(user).exactly(4).times.and_raise(rate_limit_exception)
    expect {
      twitter_client.user(user) 
    }.to raise_exception(TwitterClient::ReachedMaximumRetriesException)
  end
  
  it 'should try to reconnect if the Twitter client is rate limited while calling search', :vcr do
    twitter_client.send(:client).should_receive(:search).with(term).exactly(4).times.and_raise(rate_limit_exception)
    expect { 
      twitter_client.search(term) 
    }.to raise_exception(TwitterClient::ReachedMaximumRetriesException)
  end

  it 'should log an error if the Twittter client fails for a different reason', :vcr do
    twitter_client.send(:client).should_receive(:user).with(user).and_raise(Twitter::Error)
    twitter_client.user(user)
    twitter_client.errors.should == ["Error accessing the Twitter API. Please try later"]
  end

end