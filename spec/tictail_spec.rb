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
  
  describe "access_token" do
    
    it "should set access token to env var" do
      Tictail.access_token.should == ENV['TICTAIL_ACCESS_TOKEN']
    end
    
    it "should set access token" do
      Tictail.access_token = 'test_access_token'
      Tictail.access_token.should == 'test_access_token'
    end
  end
  
  describe "decode_id_token" do
    
    it "should decode id token" do
      Tictail.client_secret = 'secret'
      id_token = {'tictail_store_id' => 'foo'}
      encoded_id_token = JWT.encode(id_token, Tictail.client_secret)
      Tictail.decode_id_token(encoded_id_token).should == id_token
    end
  end
  
  describe "valid_id_token?" do
    
    it "should return true for valid token" do
      token = {
        'iss' => Tictail.site_url,
        'aud' => Tictail.client_id,
        'tictail_store_id' => 'foo'
      }
      Tictail.valid_id_token?(token).should be_true
    end
    
    it "should return false for invalid token" do
      token = {
        'iss' => 'foo',
        'aud' => 'bar'
      }
      Tictail.valid_id_token?(token).should be_false
    end
  end
  
  describe "store_id" do
    
    it "should set store id to env var" do
      Tictail.store_id.should == ENV['TICTAIL_STORE_ID']
    end
    
    it "should set store id" do
      Tictail.store_id = 'test_store_id'
      Tictail.store_id.should == 'test_store_id'
    end
  end
  
  describe "store" do
    
    it "should return store" do
      store = Tictail.store
      puts store.attributes
    end
  end
end