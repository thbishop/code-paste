# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_paste_session',
  :secret      => '5c2841132c972fbf05c46862564c20905f731405f50ca4a86b5a248c0b6fb4bacad5e24b0fff62fa80f85cbb87fcd1918f07ee5f01d46cd0c42d7d7158c67bec'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
