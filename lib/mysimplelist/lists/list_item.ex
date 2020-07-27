defmodule Mysimplelist.Lists.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :details, :string
    field :title, :string
    field :uuid, Ecto.UUID
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:title, :details, :uuid])
    |> validate_required([:title, :details, :uuid])
  end
end
