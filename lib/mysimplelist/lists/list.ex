defmodule Mysimplelist.Lists.List do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string

    belongs_to :user, Mysimplelist.Accounts.User

    timestamps()
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w()

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, max: 255)
  end
end
