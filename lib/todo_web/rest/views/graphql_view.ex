defmodule TodoWeb.GraphqlView do
  use TodoWeb, :view

  def render("ok.json", %{data: data}), do: data
end
