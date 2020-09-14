defmodule Mysimplelist.Lists.List do
  use Mysimplelist.Schema
  import Ecto.Changeset

  alias Mysimplelist.{Logger, Repo}

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
    |> validate_required(@required_fields)
    |> validate_length(:name, max: 255)
  end

  defp put_user_if_present(list, attrs) do
    Logger.log(attrs, :PutUserIfPresent, :warn)
    Logger.log(list, :PutUserIfPresent2, :warn)

    case attrs do
      %{"user" => user} ->
        cond do
          user.id != get_field(list, :user).id ->
            put_assoc(list, :user, user, required: true)

          user.id == get_field(list, :user).id ->
            list
        end

      _ ->
        list
    end
  end
end
