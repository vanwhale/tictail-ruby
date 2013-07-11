module Tictail
  
  class IDToken
    attr_accessor :token, :options
    
    def initialize(token, options={})
      @token = JWT.decode(token, Tictail.client_secret)
      @options = options
    end
    
    def validate!(nonce=nil)
      raise InvalidIDToken unless valid?
    end
    
    def valid?
      token['iss'] == Tictail.site_url && 
        token['aud'] == Tictail.client_id && 
        (nonce.nil? || nonce == token['nonce'])
        !store_id.nil?
    end
    
    def nonce
      options[:nonce]
    end
    
    def store_id
      token['tictail_store_id']
    end
    
    def store
      Tictail::Store.find(store_id)
    end
  end
end