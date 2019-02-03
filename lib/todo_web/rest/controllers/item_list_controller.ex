defmodule TodoWeb.ItemListController do
  use TodoWeb, :controller
  use Absinthe.Phoenix.Controller, schema: TodoWeb.Schema

  action_fallback(TodoWeb.FallbackController)

  @graphql """
  query {
    listItems {
      id
      name
      description
      insertedAt
      updatedAt
    }
  }
  """
  def index(_conn, res), do: {:graphql, res}

  @graphql """
  mutation ($listItem: CreateListItemObject!){
    listItem: createListItem(listItem: $listItem) {
      id
      name
      description
      insertedAt
      updatedAt
    }
  }
  """
  def create(_conn, res), do: {:graphql, res}

  @graphql """
  mutation ($id: UUID!, $listItem: ChangeListItemObject!){
    listItem: changeListItem(id: $id, listItem: $listItem) {
      id
      name
      description
      insertedAt
      updatedAt
    }
  }
  """
  def change(_conn, res), do: {:graphql, res}

  @graphql """
  mutation ($id: UUID!) {
    listItem: removeListItem(id: $id) {
      id
      name
      description
      insertedAt
      updatedAt
    }
  }
  """
  def delete(_conn, res), do: {:graphql, res}
end
