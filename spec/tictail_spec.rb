require 'spec_helper'

describe Tictail do

  describe "client_id" do
    
    it "should set client id to env var" do
      Tictail.client_id.should == ENV['TICTAIL_CLIENT_ID']
    end
    
    it "should set client id" do
      Tictail.client_id = 'test_client_id'
      Tictail.client_id.should == 'test_client_id'
    end
  end
    
  describe "client_secret" do
  
    it "should set client secret to env var" do
      Tictail.client_secret.should == ENV['TICTAIL_CLIENT_SECRET']
    end
    
    it "should set client secret" do
      Tictail.client_secret = 'test_client_secret'
      Tictail.client_secret.should == 'test_client_secret'
    end
  end
  
  describe "get_access_token" do
    let(:oauth_token) { OAuth2::AccessToken.new(Tictail.oauth_client, 'test_token', 'store' => {'name' => 'foo'}) }
    
    before do
      Tictail.should_receive(:get_oauth_access_token).and_return(oauth_token)
    end
    
    it 'returns access token' do
      access_token = Tictail.get_access_token(
        'auth_code',
        redirect_uri: 'http://localhost:3000/integrations/tictail/authorized'
      )
      access_token.token.should == 'test_token'
      access_token.store.should == {
        'name' => 'foo'
      }
    end
  end
end