# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_controlasuntos_session',
  :secret      => '1baf5165315f82c8dd447b6d6988ae0ade5f1ecfab00b0be0fc110d7f40761a7ea7e62f060c0c3078aa052c8e664b08d91add71be951b9267c77de38cf20d3d8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
