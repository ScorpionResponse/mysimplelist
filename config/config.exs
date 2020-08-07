# General application configuration
use Mix.Config

config :mysimplelist,
  ecto_repos: [Mysimplelist.Repo]

config :mysimplelist, Mysimplelist.Repo,
  log: false

# Configures the endpoint
config :mysimplelist, MysimplelistWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SztFXav0fvX7+n4ws5O37otVn6SK6pwMy4Zz7502LvafL2+YH1tBzEz01lfw+OvA",
  render_errors: [view: MysimplelistWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Mysimplelist.PubSub,
  live_view: [signing_salt: "3RVnGUuGo5cQYHuSGOVr6OEeGDcI+2GN5muMtKAcmwypjRyjDrWGQdIRXmrdalaP"]

# Configures Elixir's Logger
config :logger_json, :backend, metadata: :all
config :logger, backends: [LoggerJSON]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
