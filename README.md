# Tictail

This gem is a client for the [Tictail API](http://tictail.com).

## Installation

    gem install tictail

## Requirements

You will need a Tictail account, client id and client secret.

### OAuth

Configure your client id and client secret. You can either set environment variables or hardcode them.

    export TICTAIL_CLIENT_ID='YOUR_CLIENT_ID'
    export TICTAIL_CLIENT_SECRET='YOUR_CLIENT_SECRET'
    # or
    Tictail.client_id = 'YOUR_CLIENT_ID'
    Tictail.client_secret = 'YOUR_CLIENT_SECRET'

Get an authorization url:

    Tictail.authorization_url(
      scope: 'store.manage',
      state: 'CSRF_PROTECTION_TOKEN',
      redirect_uri: 'YOUR_OAUTH_CALLBACK_URI'
    )
    # => https://tictail.com/oauth/authorize?response_type=code&client_id=YOUR_CLIENT_ID&scope=store.manage&state=CSRF_PROTECTION_TOKEN&redirect_uri=REDIRECT_URI
    
Get an access token with an auth code:
  
    access_token = Tictail.get_access_token(
      'AUTH_CODE',
      redirect_uri: 'YOUR_OAUTH_CALLBACK_URI'
    )
    access_token.token # => 'STORE_OAUTH_ACCESS_TOKEN'
    access_token.store_id # => 'STORE_ID'
    access_token.store # => Tictail::Store instance

Build an access token with a saved access token

    access_token = Tictail::AccessToken.new(
      token: 'STORE_OAUTH_ACCESS_TOKEN',
      store_id: 'STORE_ID
    )

### Customers and Followers

    client = TictailClient.new(access_token)
    customers = client.customers
    customer_emails = customers.map{|customer| customer['email']}
    followers = client.followers
    follower_emails = followers.map{|follower| follower['email']}

### Feed cards

    client = TictailClient.new(access_token)
    client.create_card(
      title: 'Welcome to our Tictail app',
      action: 'http://example.com/',
      card_type: 'media',
      content: {
        header: 'Welcome!',
        caption: 'Enjoy your stay',
        image: 'http://placekitten.com/800/450'
      }
    )
    card_titles = client.cards.map{|card| card['title']}