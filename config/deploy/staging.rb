# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '45.33.124.125', user: 'webdev', roles: %w{app db web}

set :ssh_options, {
  forward_agent: true
}
