defmodule Mysimplelist.Lists.List do
  use Mysimplelist.Schema
  import Ecto.Changeset

  schema "lists" do
    field(:name, :string)

    belongs_to(:user, Mysimplelist.Accounts.User)

    timestamps()
  end

  @required_fields ~w(name)a
  @optional_fields ~w(user_id)a

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> put_user_if_present(attrs)
    |> validate_required(@required_fields)
    |> validate_length(:name, max: 255)
  end

  defp put_user_if_present(list, attrs) do
    case attrs do
      %{"user" => user} ->
        put_assoc(list, :user, user, required: true)

      _ ->
        list
    end
  end
end
