module Tictail
  
  class Client
    include HTTParty
    base_uri 'https://api.tictail.com/v1'
    debug_output
    
    attr_reader :token, :store_id
    
    def initialize(access_token)
      @token = access_token.token
      @store_id = access_token.store_id
    end
    
    def method_missing(method, *args)
      method_string = method.to_s
      is_setter_method = method_string[-1, 1] == '='
      key = method_string.gsub(/\=/, '')
      
      if is_setter_method
        attributes[key] = args.first
      elsif attributes.include?(key)
        attributes[key]
      else
        super
      end
    end
    
    def store
      response = self.class.get(
        '/stores/%s' % store_id,
        headers: headers
      )
      response.parsed_response
    end
    
    def customers(params={})
      response = self.class.get(
        '/stores/%s/customers' % store_id,
        headers: headers,
        query: params
      )
      response.parsed_response
    end
    
    def followers(params={})
      response = self.class.get(
        '/stores/%s/followers' % store_id,
        headers: headers,
        query: params
      )
      response.parsed_response
    end
    
    def headers
      {
        'Authorization' => 'Bearer %s' % token,
        'Cookie' => 'ticman=ticman'
      }
    end
  end
end