import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :yauth, Yauth.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "yauth_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :yauth, YauthWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "u+y7R8Iwgi8OUSx9O1N0ehQvBRlhHXdxeK87JYi0z5NVWcGglyg5w5JzpCM2seam",
  server: false

# In test we don't send emails.
config :yauth, Yauth.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
