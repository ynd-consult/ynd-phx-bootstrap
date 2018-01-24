# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ynd_phx_bootstrap,
  ecto_repos: [YndPhxBootstrap.Repo]

# Configures the endpoint
config :ynd_phx_bootstrap, YndPhxBootstrapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aAvpOkljeG+EukvHQ7I2eQ6brUY0xZF87XtFvSdJNe6zZPd5ktovqzOi5utqssxh",
  render_errors: [view: YndPhxBootstrapWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: YndPhxBootstrap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :sentry,
  dsn: "https://public:secret@app.getsentry.com/1",
  environment_name: Mix.env,
  included_environments: [:prod],
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  tags: %{
    env: "production"
  },
  hackney_opts: [pool: :my_pool],
  in_app_module_whitelist: [YndPhxBootstrap]

import_config "#{Mix.env}.exs"

if File.exists? "config/#{Mix.env}.secret.exs" do
  import_config "#{Mix.env}.secret.exs"
end
