import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_flip_demo, LiveFlipDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "59DTsQj9P8HxvUwJLhYYE6s0mHuFS6CfbHinBwvFXbzKBSxBv5G3GPO9riimadwn",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
