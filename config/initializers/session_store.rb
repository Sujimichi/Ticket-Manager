# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ticket_manager_session',
  :secret      => 'd671de794f95742e9bdf769e51ac1a16b15054756140945efdc0d8dec8ddb840aef05909479b52ecd611b36329f3fc4e4057307ce6922f0e5fe7b57bff9ef140'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
