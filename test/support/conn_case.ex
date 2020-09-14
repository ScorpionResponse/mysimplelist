defmodule MysimplelistWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MysimplelistWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias Mysimplelist.Accounts
  alias MysimplelistWeb.Session

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import MysimplelistWeb.ConnCase

      alias MysimplelistWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint MysimplelistWeb.Endpoint
    end
  end

  @test_user_attrs %{email: "test@example.com", name: "Test Name"}

  defp with_session(conn) do
    {:ok, user} = Accounts.create_user(@test_user_attrs)
    test_user_token = Session.tokenize_user(user)

    conn
    |> Plug.Test.init_test_session(current_user_token: test_user_token)
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Mysimplelist.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Mysimplelist.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()

    if tags[:with_session], do: with_session(conn)

    {:ok, conn: conn}
  end
end
