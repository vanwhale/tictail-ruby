require 'digest/sha1'

module Tictail
  
  class SSOToken
    attr_accessor :store_id, :token, :timestamp
    
    def initialize(options={})
      @store_id = options[:store_id]
      @token = options[:token]
      @timestamp = options[:timestamp]
      validate!
    end
    
    def validate!
      raise InvalidSSOToken unless valid?
    end
    
    def valid?
      valid_timestamp? && valid_token?
    end
    
    def valid_timestamp?
      (Time.now.to_i - 30) < timestamp
    end
    
    def valid_token?
      hash == token
    end
    
    def hash
      Digest::SHA1.digest([store_id, Tictail.client_secret, timestamp].join(":"))
    end
  end
end