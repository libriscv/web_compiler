import Config

config :web_compiler, Oban, testing: :inline

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :web_compiler, WebCompiler.Repo,
  adapter: Ecto.Adapters.SQLite3,
  database: "priv/repo/web_compiler_test.db",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_compiler, WebCompilerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "KyZcZTIUoFWuRMhgCGJAAzdLpYJmlTld/NzGT+pD2gUBZOxwDeMn1bE252HOiNHM",
  server: false

# In test we don't send emails
config :web_compiler, WebCompiler.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
