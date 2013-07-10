module Tictail
  
  class IDToken
    attr_accessor :token
    
    def initialize(encoded_id_token)
      self.token = JWT.decode(encoded_id_token, Tictail.client_secret)
      validate!
    end
    
    def validate!
      raise InvalidIDToken unless token['iss'] == Tictail.site_url && 
        token['aud'] == Tictail.client_id && 
        !store_id.nil?
    end
    
    def store_id
      token['tictail_store_id']
    end
    
    def store
      Tictail::Store.find(store_id)
    end
  end
end