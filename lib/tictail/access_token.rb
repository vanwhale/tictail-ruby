module Tictail

  class AccessToken
    
    attr_accessor :token, :store, :store_id
    
    def initialize(attributes)
      @token = attributes[:token]
      @store = attributes[:store]
      @store_id = attributes[:store_id] || store['id']
    end
  end
end