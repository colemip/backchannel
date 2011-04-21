# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_backchannel_session',
  :secret      => 'e7327b1e3f5a40c0786771c307eb453095d48d89a10533d0542157f53c05ed8fc16e472a66108266cb172be87c24f6afc7faabed64bacd90b6413a10f58c9b9f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
