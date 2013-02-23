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
  
  it 'should load the specified users feed' do
    client.fetch(user).should be_kind_of(Twitter::User)
  end
  
  it 'should have the users name' do
    client.fetch(user).name == "Joe Connor"
  end

  it 'should get the users status' do
    client.fetch(user).status.text.should == status
  end

end