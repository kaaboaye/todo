defmodule TodoWeb.Router do
  use TodoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward("/api", Absinthe.Plug, schema: TodoWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: TodoWeb.Schema)
  end
end
