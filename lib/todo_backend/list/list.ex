defmodule Todo.List do
  alias Todo.List.Item
  alias Todo.Repo

  def get_list_items do
    Repo.all(Item)
  end

  def create_list_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def change_list_item(list_item_id, attrs) do
    with %{} = item <- Repo.get(Item, list_item_id) do
      item
      |> Item.changeset(attrs)
      |> Repo.update()
    else
      nil -> {:error, "List item not found"}
    end
  end

  def remove_list_item(list_item_id) do
    with %{} = item <- Repo.get(Item, list_item_id) do
      Repo.delete(item)
    else
      nil -> {:error, "List item not found"}
    end
  end
end
