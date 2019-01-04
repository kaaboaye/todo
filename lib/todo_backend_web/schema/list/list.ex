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

  object :mutate_list do
    field :create_list_item, :list_item do
      arg(:list_item, non_null(:create_list_item_object))
      resolve(&create_list_item/3)
    end

    field :change_list_item, :list_item do
      arg(:list_item, non_null(:change_list_item_object))
      resolve(&change_list_item/3)
    end

    field :remove_list_item, :list_item do
      arg(:list_item_id, non_null(:uuid))
      resolve(&remove_list_item/3)
    end
  end

  defp create_list_item(_, %{list_item: attrs}, _) do
    List.create_list_item(attrs)
  end

  defp change_list_item(_, %{list_item: attrs}, _) do
    List.change_list_item(attrs.id, attrs)
  end

  defp remove_list_item(_, %{list_item_id: list_item_id}, _) do
    List.remove_list_item(list_item_id)
  end
end
