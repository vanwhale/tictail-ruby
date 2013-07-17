module Tictail

  class AccessToken
    
    attr_accessor :token, :store
    
    def initialize(attributes)
      self.token = attributes[:token]
      self.store = attributes[:store]
    end
  end
end