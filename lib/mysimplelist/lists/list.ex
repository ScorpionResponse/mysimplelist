defmodule Mysimplelist.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string
    field :uuid, Ecto.UUID
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :uuid])
    |> validate_required([:name, :uuid])
  end
end
