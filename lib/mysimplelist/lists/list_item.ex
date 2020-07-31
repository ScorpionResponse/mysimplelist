defmodule Mysimplelist.Lists.ListItem do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :title, :string
    field :details, :string
    field :complete, :boolean
    field :completed_at, :utc_datetime_usec

    belongs_to :list, Mysimplelist.Lists.List

    timestamps()
  end

  @required_fields ~w(title list_id)
  @optional_fields ~w(details complete)

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, max: 255)
  end
end
