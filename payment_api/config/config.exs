# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :payment_api,
  ecto_repos: [PaymentApi.Repo]

# Configures the endpoint
config :payment_api, PaymentApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZUWhjMsXVTBJWrlVgxEaUxOaCTZhohVT5z3P3PalXcgCEbxYGwZNIpHlUenDIGPJ",
  render_errors: [view: PaymentApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PaymentApi.PubSub,
  live_view: [signing_salt: "umceaN6j"]

config :payment_api, PaymentApi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
