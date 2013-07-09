# Tictail

This gem is a client for the [Tictail API](http://tictail.com).


## Installation

    gem install tictail


## Requirements

You will need a Tictail account, client id and client secret.


## Usage

Configure your oauth client id and client secret if you would like to use this library to handle oauth. You can either set the environment variables or hardcode them.

    export TICTAIL_CLIENT_ID='YOUR_CLIENT_ID'
    export TICTAIL_CLIENT_SECRET='YOUR_CLIENT_SECRET'
    # or
    Tictail.client_id = 'YOUR_CLIENT_ID'
    Tictail.client_secret = 'YOUR_CLIENT_SECRET'

Alternatively, you can just use your oauth access token and store id if you already have them.

    export TICTAIL_ACCESS_TOKEN='YOUR_ACCESS_TOKEN'
    export TICTAIL_STORE_ID='YOUR_STORE_ID'
    # or
    Tictail.access_token = 'YOUR_ACCESS_TOKEN'
    Tictail.store_id = 'YOUR_STORE_ID'

### OAuth

Get an authorization url:

    Tictail.authorization_url(
      scope: 'store.manage',
      state: 'RANDOM_TOKEN_FOR_CSRF_PROTECTION',
      redirect_uri: 'YOUR_OAUTH_CALLBACK_URI'
    )
    
Get an access token with an auth code:
  
    # This saves your access token to Tictail.access_token and
    # your store id to Tictail.store_id
    Tictail.get_access_token(
      'AUTH_CODE',
      redirect_uri: 'YOUR_OAUTH_CALLBACK_URI'
    )
    Tictail.access_token # => 'YOUR_ACCESS_TOKEN'
    Tictail.store_id # => 'YOUR_STORE_ID'

### Store

Tictail.store