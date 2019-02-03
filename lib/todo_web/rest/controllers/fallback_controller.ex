defmodule TodoWeb.FallbackController do
  use TodoWeb, :controller

  def call(conn, {:graphql, data}) do
    conn
    |> put_view(TodoWeb.GraphqlView)
    |> render("ok.json", data: data)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> render(TodoWeb.ErrorView, :"400")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(TodoWeb.ErrorView, :"401")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(TodoWeb.ErrorView, :"404")
  end
end
