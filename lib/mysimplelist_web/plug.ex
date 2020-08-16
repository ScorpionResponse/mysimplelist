defmodule MysimplelistWeb.Plug.SetCurrentUser do
  import Plug.Conn, only: [get_session: 2, put_session: 3, assign: 3]

  alias Mysimplelist.{Accounts, Logger}
  alias MysimplelistWeb.Session

  def init(options), do: options

  def call(conn, _opts) do
    case get_session(conn, :current_user_token) do
      nil ->
        # TODO: Temporary 'authentication'
        # probably just do nothing and separately plug out redirecting unknown users
        Logger.log("Using default user", :UserDefaulted, :warn)
        assumed_user = Accounts.get_user!("f0269e68-b976-44c2-a8d5-ba5e6d93e6c1")
        assumed_user_token = Session.tokenize_user(assumed_user)

        conn
        |> assign(:current_user, assumed_user)
        |> put_session(:current_user, assumed_user)
        |> put_session(:current_user_token, assumed_user_token)

      user_token ->
        case Session.user_from_token(user_token) do
          {:ok, current_user} -> assign(conn, :current_user, current_user)
          {:error, nil} -> conn
        end
    end
  end
end
