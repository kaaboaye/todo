defmodule TodoWeb.Schema do
  use Absinthe.Schema

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def middleware(middleware, field, object) do
    apply(middleware, :errors, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [TodoWeb.Middleware.ChangesetErrors]
  end

  defp apply(middleware, _, _, _) do
    middleware
  end

  def dataloader() do
    Dataloader.new()
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  import_types(TodoWeb.Types.UUID)

  import_types(TodoWeb.List)
  import_types(TodoWeb.List.Item)

  query do
    import_fields(:query_list)
  end

  mutation do
    import_fields(:mutate_list)
  end

  subscription do
    import_fields(:subscribe_list_item)
  end
end
