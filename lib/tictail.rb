require 'httparty'
require 'multi_json'
require 'oauth2'
require 'jwt'

module Tictail
  extend self
  
  autoload :AccessToken, 'tictail/access_token'
  autoload :IDToken, 'tictail/id_token'
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
      oauth_access_token = get_oauth_access_token(*args)
      id_token = IDToken.new(oauth_access_token.params['id_token'])
      AccessToken.new(
        token: oauth_access_token.token,
        store_id: id_token.store_id
      )
    end
    
    def get_oauth_access_token(*args)
      oauth_client.auth_code.get_token(*args)
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