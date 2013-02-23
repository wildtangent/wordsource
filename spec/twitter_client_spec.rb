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

end