defmodule Todo.List.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts type: :utc_datetime
  schema "todo_list_items" do
    field :description, :string
    field :done, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :done])
    |> validate_required([:name, :description, :done])
  end
end
