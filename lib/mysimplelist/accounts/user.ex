defmodule Mysimplelist.Accounts.User do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, max: 255)
    |> validate_length(:email, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
