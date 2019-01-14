defmodule TodoWeb.List.Item do
  use Absinthe.Schema.Notation

  alias Todo.List

  object :list_item do
    field :id, non_null(:uuid)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :done, non_null(:boolean)
    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  input_object :create_list_item_object do
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :done, :boolean
  end

  input_object :change_list_item_object do
    field :id, non_null(:uuid)
    field :name, :string
    field :description, :string
    field :done, :boolean
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

  object :subscribe_list_item do
    field :list_item_created, non_null(:list_item) do
      config(fn _, _ -> {:ok, topic: "*"} end)
      trigger(:create_list_item, topic: fn _ -> "*" end)
    end

    field :list_item_changed, non_null(:list_item) do
      config(fn _, _ -> {:ok, topic: "*"} end)
      trigger(:change_list_item, topic: fn _ -> "*" end)
    end
  end
end
