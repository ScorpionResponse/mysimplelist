defmodule MysimplelistWeb.Session do
  alias Mysimplelist.Accounts
  alias Mysimplelist.Accounts.User

  def tokenize_user(%User{} = user) do
    tokenize_user(user.id)
  end

  def tokenize_user(user_id) when is_binary(user_id) do
    Phoenix.Token.sign(MysimplelistWeb.Endpoint, signing_salt(), user_id)
  end

  def user_from_token(user_token) do
    case Phoenix.Token.verify(MysimplelistWeb.Endpoint, signing_salt(), user_token) do
      {:ok, user_id} ->
        {:ok, Accounts.get_user!(user_id)}

      {:error, _} ->
        {:error, nil}
    end
  end

  def user_from_token!(user_token) do
    case user_from_token(user_token) do
      {:ok, user} ->
        user

      {:error, _} ->
        raise MysimplelistWeb.AuthenticationError, message: "Unknown user"
    end
  end

  def replace_token_with_user_in(obj, current_key \\ "current_user_token", replace_key \\ "user") do
    {token, obj_partial} = Map.get_and_update(obj, current_key, fn _ -> :pop end)
    Map.put_new(obj_partial, replace_key, user_from_token!(token))
  end

  defp signing_salt() do
    MysimplelistWeb.Endpoint.config(:live_view)[:signing_salt] ||
      raise MysimplelistWeb.AuthenticationError, message: "missing signing_salt"
  end
end
