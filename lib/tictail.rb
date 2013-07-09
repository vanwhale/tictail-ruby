require 'httparty'
require 'multi_json'
require 'oauth2'
require 'jwt'

module Tictail
  extend self
  
  autoload :Store, 'tictail/store'
  autoload :Request, 'tictail/request'
  autoload :Resource, 'tictail/resource'
  
  class << self
    attr_accessor :client_id, :client_secret, :access_token, :store_id
    
    def authorize_url(*args)
      oauth_client.auth_code.authorize_url(*args)
    end
    
    def oauth_client
      OAuth2::Client.new(client_id, client_secret, :site => site_url)
    end
    
    def site_url
      'https://tictail.com'
    end
    
    def get_access_token(*args)
      oauth_token = oauth_client.auth_code.get_token(*args)
      encoded_id_token = oauth_token.params['id_token']
      id_token = decode_id_token(encoded_id_token)
      if valid_id_token?(id_token)
        self.store_id = id_token['tictail_store_id']
        self.access_token = oauth_token.token
      else
        raise InvalidIDToken
      end
      access_token
    end
    
    def decode_id_token(encoded_id_token)
      JWT.decode(encoded_id_token, client_secret)
    end
    
    def valid_id_token?(id_token)
      id_token['iss'] == site_url && 
        id_token['aud'] == client_id && 
        !id_token['tictail_store_id'].nil?
    end
    
    def store
      Tictail::Store.find(store_id)
    end
  end
  
  class BadRequest < StandardError
  end
  
  class ResourceNotFound < StandardError
  end
  
  class Unauthorized < StandardError
  end
  
  class InvalidIDToken < StandardError
  end
end

Tictail.client_id = ENV['TICTAIL_CLIENT_ID']
Tictail.client_secret = ENV['TICTAIL_CLIENT_SECRET']

if ENV['TICTAIL_ACCESS_TOKEN']
  Tictail.access_token = ENV['TICTAIL_ACCESS_TOKEN']
end

if ENV['TICTAIL_STORE_ID']
  Tictail.store_id = ENV['TICTAIL_STORE_ID']
end