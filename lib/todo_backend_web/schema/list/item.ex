defmodule TodoWeb.List.Item do
  use Absinthe.Schema.Notation

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
    field :id, :uuid
    field :name, :string
    field :description, :string
    field :done, :boolean
  end
end
