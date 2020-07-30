defmodule Mysimplelist.Lists.List do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string

    belongs_to :user, Mysimplelist.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 255)
  end
end
