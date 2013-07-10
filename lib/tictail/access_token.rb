module Tictail

  class AccessToken
    
    attr_accessor :token, :store_id
    
    def initialize(attributes)
      self.token = attributes[:token]
      self.store_id = attributes[:store_id]
    end
    
    def store
      Tictail::Store.find(store_id)
    end
  end
end