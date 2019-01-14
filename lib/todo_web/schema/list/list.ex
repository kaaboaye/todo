defmodule TodoWeb.List do
  use Absinthe.Schema.Notation

  alias Todo.List

  object :query_list do
    field :list_items, non_null(list_of(non_null(:list_item))) do
      resolve(&items/3)
    end
  end

  defp items(_, _, _) do
    items = List.get_list_items()
    {:ok, items}
  end
end
