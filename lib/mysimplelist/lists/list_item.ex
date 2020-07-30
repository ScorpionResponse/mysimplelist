defmodule Mysimplelist.Lists.ListItem do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :title, :string
    field :details, :string
    field :complete, :boolean
    field :completed_at, :utc_datetime_usec
    field :list_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:title, :details, :complete])
    |> validate_required([:title])
    |> validate_length(:title, max: 255)
  end
end
