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

  scope "/rest", TodoWeb do
    pipe_through :api

    get "/list_items", ItemListController, :index
    post "/list_items", ItemListController, :create
    patch "/list_items/:id", ItemListController, :change
    delete "/list_items/:id", ItemListController, :delete
  end
end
