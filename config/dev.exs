use Mix.Config

# Database
config :mysimplelist, Mysimplelist.Repo,
  username: "postgres",
  password: "postgres",
  database: "mysimplelist_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  migration_primary_key: [name: :id, type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]

# Endpoint
config :mysimplelist, MysimplelistWeb.Endpoint,
  http: [port: 4040],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Configure live_reload
config :mysimplelist, MysimplelistWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/mysimplelist_web/(live|views)/.*(ex)$",
      ~r"lib/mysimplelist_web/templates/.*(eex)$"
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
