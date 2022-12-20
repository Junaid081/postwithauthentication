# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :yauth,
  ecto_repos: [Yauth.Repo]

# Configures the endpoint
config :yauth, YauthWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: YauthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Yauth.PubSub,
  live_view: [signing_salt: "zR2Qqa0/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :yauth, Yauth.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      param_nesting: "account",
      request_path: "/register",
      callback_path: "/register",
      callback_methods: ["POST"]
    ]}
  ]

  config :yauth, YauthWeb.Authentication,
  issuer: "yauth",
  secret_key: "rQW7mFXxHoKA/GQRutIZUZvpV7kbLOfQha4zKR4+B87Q7tDfl/8I60YnO85iY2LG"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
# import_config "#{Mix.env()}.exs"
