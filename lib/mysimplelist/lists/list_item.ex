defmodule Mysimplelist.Lists.ListItem do
  @moduledoc "A simple item in a list that can be completed"
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

  @required_fields ~w(title list_id)a
  @optional_fields ~w(details complete)a

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, max: 255)
    |> handle_completed_at
  end

  @doc "Set the completed_at field if the complete checkbox is checked"
  defp handle_completed_at(changeset) do
    complete = get_change(changeset, :complete)
    changeset
    |> put_change(:completed_at, (if complete, do: DateTime.utc_now, else: nil))
  end
end
