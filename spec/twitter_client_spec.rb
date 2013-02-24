require 'spec_helper'

describe TwitterClient do
  
  let :client do
    TwitterClient.new
  end
  
  let :user do
    "wildtangent"
  end

  let :status do
    "Picture cannot hope to do justice to the skills this man has on the joanna! http://t.co/6cB0y53s"
  end
    
  let :rate_limit_exception do
    exception = Twitter::Error::TooManyRequests.new
    exception.rate_limit.update({
      'x-rate-limit-limit' => 350, 
      'x-rate-limit-reset' => (Time.now.to_i + 5) 
    })
    exception
  end
  
  it 'should load the specified users feed', :vcr do
    client.user(user).should be_kind_of(Twitter::User)
  end
  
  it 'should have the users name', :vcr do
    client.user(user).name == "Joe Connor"
  end

  it 'should get the users status', :vcr do
    client.user(user).status.text.should == status
  end
  
  it 'should get a set of search results', :vcr do
    client.search("bbc").statuses.should_not be_empty
  end
  
  it 'should try to reconnect if the Twitter client is rate limited while calling user', :vcr do
    client.client.should_receive(:user).with(user).exactly(4).times.and_raise(rate_limit_exception)
    expect {client.user("wildtangent") }.to raise_exception(TwitterClient::ReachedMaximumRetriesException)
    
  end
  
  it 'should try to reconnect if the Twitter client is rate limited while calling search', :vcr do
    client.client.should_receive(:search).with("geckoboard").exactly(4).times.and_raise(rate_limit_exception)
    expect { client.search("geckoboard") }.to raise_exception(TwitterClient::ReachedMaximumRetriesException)
    
  end

end