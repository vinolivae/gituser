# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :gituser,
  ecto_repos: [Gituser.Repo]

config :gituser, Gituser.User.Commands.ListUserData, github_adapter: Gituser.Clients.Github

config :gituser, GituserWeb.Auth.Guardian,
  issuer: "gituser",
  secret_key: "Secret key. You can use `mix guardian.gen.secret` to get one"

config :gituser, GituserWeb.Auth.Pipeline,
  module: GituserWeb.Auth.Guardian,
  error_handler: GituserWeb.Auth.ErrorHandler

# Configures the endpoint
config :gituser, GituserWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: GituserWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gituser.PubSub,
  live_view: [signing_salt: "apxVv8OP"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :gituser, Gituser.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
