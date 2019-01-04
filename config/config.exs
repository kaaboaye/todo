# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_backend,
  namespace: Todo,
  ecto_repos: [Todo.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :todo_backend, TodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4Py11YMmwIHShbfyUmsA0sF6DITERJKBtmK14Ni5KsnBXVz1g//w6lS3PCrlKY5q",
  render_errors: [view: TodoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Todo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
