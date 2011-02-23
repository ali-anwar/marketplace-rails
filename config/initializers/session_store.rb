# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_geboon_session',
  :secret      => '1b13507afc4ef9f4f6bde19d5aeee44168a0e5a9fad3f69f9dd8544afc271b9cdea9669f5d62c421ea17944514e47c55b4e705e35712b6dde963dc1dbbfc794d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
